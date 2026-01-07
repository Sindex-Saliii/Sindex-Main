// ==UserScript==
// @name         SaliiiX Sound Tuning
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Audio enhancement
// @author       You
// @match        *://*/*
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function() {
    'use strict';

    let audioContext = null;
    let source = null;
    let processor = null;
    let destination = null;
    let enabled = false;
    let toggleButton = null;

    function init() {
        createToggleButton();
        loadState();
    }

    function createToggleButton() {
        toggleButton = document.createElement('button');
        toggleButton.id = 'saliix-toggle';
        toggleButton.innerHTML = 'SaliiiX Sound Tuning: OFF';
        toggleButton.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 999999;
            background: #333;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            font-family: Arial, sans-serif;
            font-size: 12px;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            transition: all 0.3s;
        `;

        toggleButton.addEventListener('click', function() {
            enabled = !enabled;
            updateButton();
            saveState();

            if (enabled) {
                initializeAudio();
            } else {
                disconnectAudio();
            }
        });

        document.body.appendChild(toggleButton);
    }

    function updateButton() {
        if (enabled) {
            toggleButton.innerHTML = 'SaliiiX Sound Tuning: ON';
            toggleButton.style.background = '#007bff';
            toggleButton.style.color = 'white';
        } else {
            toggleButton.innerHTML = 'SaliiiX Sound Tuning: OFF';
            toggleButton.style.background = '#333';
            toggleButton.style.color = 'white';
        }
    }

    function saveState() {
        localStorage.setItem('saliixEnabled', enabled);
    }

    function loadState() {
        const saved = localStorage.getItem('saliixEnabled');
        if (saved !== null) {
            enabled = saved === 'true';
            updateButton();
            if (enabled) {
                setTimeout(() => initializeAudio(), 1000);
            }
        }
    }

    async function initializeAudio() {
        try {
            if (audioContext) {
                disconnectAudio();
            }

            audioContext = new (window.AudioContext || window.webkitAudioContext)();

            const audioElements = document.querySelectorAll('audio, video');
            if (audioElements.length === 0) return;

            const firstAudio = audioElements[0];
            source = audioContext.createMediaElementSource(firstAudio);
            processor = audioContext.createScriptProcessor(256, 1, 1);
            destination = audioContext.destination;

            processor.onaudioprocess = (event) => {
                const input = event.inputBuffer.getChannelData(0);
                const output = event.outputBuffer.getChannelData(0);

                for (let i = 0; i < input.length; i++) {
                    let sample = input[i];

                    sample = applyBass(sample);
                    sample = applyMids(sample);
                    sample = applyTreble(sample);
                    sample = applyCompression(sample);

                    output[i] = sample;
                }
            };

            source.connect(processor);
            processor.connect(destination);

            for (let element of audioElements) {
                element.play().catch(e => console.log('Autoplay prevented'));
            }

        } catch (error) {
            console.error('Audio processing error:', error);
            enabled = false;
            updateButton();
            saveState();
        }
    }

    function applyBass(sample) {
        const bassBoost = 1.4;
        if (Math.abs(sample) < 0.4) {
            sample *= bassBoost;
        }
        return sample * 1.2;
    }

    function applyMids(sample) {
        const midBoost = 1.25;
        if (Math.abs(sample) > 0.3 && Math.abs(sample) < 0.7) {
            sample *= midBoost;
        }
        return sample;
    }

    function applyTreble(sample) {
        const trebleBoost = 1.35;
        if (Math.abs(sample) > 0.6) {
            sample *= trebleBoost;
        }
        return sample;
    }

    function applyCompression(sample) {
        const threshold = 0.8;
        const ratio = 3.0;
        const makeup = 1.25;

        const absSample = Math.abs(sample);
        if (absSample > threshold) {
            const over = absSample - threshold;
            const compressed = over / ratio;
            sample = Math.sign(sample) * (threshold + compressed);
        }

        sample *= makeup;

        if (sample > 0.99) sample = 0.99;
        if (sample < -0.99) sample = -0.99;

        return sample;
    }

    function disconnectAudio() {
        if (processor && source) {
            source.disconnect();
            processor.disconnect();
        }
        if (audioContext) {
            audioContext.close();
            audioContext = null;
        }
        source = null;
        processor = null;
        destination = null;
    }

    window.addEventListener('load', init);
})();
