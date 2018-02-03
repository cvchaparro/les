(function recordStudentAnswer() {
    const DEFAULT_PAUSE_BEFORE_RECORDING_IN_SECONDS = 3;
    const DEFAULT_RECORDING_LENGTH_IN_SECONDS = 30;

    let recordingStarted = false;

    let microphone;
    document.body.onload = event => setMicrophone();

    let question = document.getElementById("question");
    let answer = document.getElementById("answer");
    let download = document.getElementById("download");

    let playQuestionButton = document.getElementById("play-question");
    playQuestionButton.onclick = event => {
        document.getElementById("question").play();
    };

    let recordAnswerButton = document.getElementById("record-answer");
    recordAnswerButton.onclick = event => {
        if (!recordingStarted) {
            if (!microphone)
                setMicrophone();

            recordingStarted = true;
            recordAnswer(
                DEFAULT_PAUSE_BEFORE_RECORDING_IN_SECONDS,
                DEFAULT_RECORDING_LENGTH_IN_SECONDS
            );
        }
    };

    function setMicrophone() {
        if (!navigator.mediaDevices) {
            let message = "Unsupported configuration! We cannot access your microphone!";
            alert(message);
            throw message;
        }

        microphone = navigator.mediaDevices.getUserMedia({ audio : true });
    }

    function millisecondsToSeconds(milliseconds) {
        milliseconds = milliseconds || 0;
        return milliseconds / 1000;
    }

    function secondsToMilliseconds(seconds) {
        seconds = seconds || 0;
        return seconds * 1000;
    }

    function wait(delayInSeconds) {
        return new Promise(
            resolve =>
                setTimeout(resolve, secondsToMilliseconds(delayInSeconds))
        );
    }

    function countdown(delayInSeconds) {
        if (delayInSeconds >= 1) {
            setCountdownContentMessage("Start recording your answer in: " + delayInSeconds + " seconds.");
            return new Promise(resolve => {
                wait(1).then(() => {
                    countdown(delayInSeconds - 1).then(resolve);
                });
            });
        }
        return new Promise(resolve => { resolve(); });
    }

    function setCountdownContentMessage(message) {
        let countdownContent = document.getElementById("countdown-content");
        if (countdownContent.parentNode.style.display === "") {
            countdownContent.parentNode.style.display = "block";
        }
        countdownContent.innerHTML = message;
    }

    function startRecording(stream, pauseTime, recordTime) {
        let recorder = new MediaRecorder(stream);
        let data = [];

        recorder.ondataavailable = event => data.push(event.data);

        return countdown(pauseTime)
            .then(() => {
                setCountdownContentMessage("Started recording...");
                recorder.start();

                let stopped = new Promise((resolve, reject) => {
                    recorder.onstop = resolve;
                    recorder.onerror = event => reject(event.name);
                });

                let recorded = wait(recordTime).then(() => {
                    setCountdownContentMessage("Stopped recording!");
                    recorder.state == "recording" && recorder.stop();
                    recordingStarted = false;
                });

                return Promise.all([
                    stopped,
                    recorded
                ]).then(() => data);
            });
    }

    function recordAnswer(pauseTime, recordTime) {
        microphone
            .then(stream => {
                answer.srcObject = stream;
                download.href = stream;
                answer.captureStream = answer.captureStream || answer.mozCaptureStream;
            })
            .then(() => startRecording(answer.captureStream(), pauseTime, recordTime))
            .then(data => {
                let recordedAnswer = new Blob(data, { type: "application/ogg" });
                answer.src = URL.createObjectURL(recordedAnswer);
                download.href = answer.src;
                download.download = "answer-01.ogg";
                setCountdownContentMessage("Download and save your recording!");
                document.getElementById("download").innerHTML = "&#x2B07;";
            })
            .catch(reason => {
                microphone = null;
                alert("An error occurred due to " + reason);
                console.log(reason);
            });
    }
})();
