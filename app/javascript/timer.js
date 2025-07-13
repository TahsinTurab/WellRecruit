document.addEventListener("DOMContentLoaded", function() {
    var timerDisplay = document.getElementById('timer');
    var form = document.getElementById('assessment-form');

    function updateTimer() {
        var now = new Date().getTime();
        var timeLeft = endTime - now;

        if (timeLeft <= 0) {
            clearInterval(timerInterval);
            timerDisplay.innerHTML = "Time's up!";
            var checkboxes = document.querySelectorAll('.form-check-input');
            checkboxes.forEach(function(checkbox) {
                if (!checkbox.checked) {
                    checkbox.disabled = true;
                }
                checkbox.hidden = true;
            });

            alert("Time's up! You can't select any options anymore. Please submit the participation");
        }

        var hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);

        timerDisplay.innerHTML = hours + "h " + minutes + "m " + seconds + "s ";
    }

    var timerInterval = setInterval(updateTimer, 1000);
    updateTimer(); // Initial call to set the timer immediately
});
