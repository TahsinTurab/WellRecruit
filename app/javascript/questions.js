
document.addEventListener("DOMContentLoaded", function() {
    const addQuestionLink = document.getElementById("add-question");
    const questionsDiv = document.getElementById("questions");

    addQuestionLink.addEventListener("click", function(e) {
        e.preventDefault();

        const newQuestionDiv = document.createElement("div");
        newQuestionDiv.classList.add("question");

        // Generate the HTML for the question and options using template literals
        let optionsHTML = '<div class="form-group row">\n' +
            '    <div class="col-sm-2">Options</div>\n' +
            '    <div class="col-sm-10">';

        for (let i = 0; i < 4; i++) {
            optionsHTML += `
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="gridCheck1" name="assessment[questions_attributes][][answers_attributes][][correct]">
                <label class="form-check-label" for="gridCheck1">
                  <input type="text" class="form-control" name="assessment[questions_attributes][][answers_attributes][][option]">
                </label>
            </div>
      `;
        }

        optionsHTML += '    </div>\n' +
            '  </div>';
        newQuestionDiv.innerHTML = `
      <div class="form-group row">
        <label for="inputEmail3" class="col-sm-2 col-form-label">Question</label>
        <div class="col-sm-10">
          <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="assessment[questions_attributes][][statement]"></textarea>
        </div>
      </div>
      <br>
      ${optionsHTML}
      
      <button class="remove-question btn btn-danger btn-sm">Remove Question</button>
      <hr>
    `;

        questionsDiv.appendChild(newQuestionDiv);

        // Attach remove functionality
        newQuestionDiv.querySelector(".remove-question").addEventListener("click", function(e) {
            e.preventDefault();
            newQuestionDiv.remove();
        });
    });

    document.querySelectorAll(".remove-question").forEach(function(link) {
        link.addEventListener("click", function(e) {
            e.preventDefault();
            this.closest(".question").remove();
        });
    });
});
