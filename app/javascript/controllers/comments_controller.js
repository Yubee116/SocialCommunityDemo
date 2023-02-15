import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
    }
    toggleForm(event) {
        event.preventDefault();
        event.stopPropagation();

        const commentFormId = event.params['form']
        const commentID = event.params['comment']

        const form = document.getElementById(commentFormId)
        const comment = document.getElementById(commentID)

        form.classList.toggle("hidden")
        comment.classList.toggle("hidden")

    }

    toggleFormCancel(event) {
        event.preventDefault();
        event.stopPropagation();

        const commentFormId = event.params['form']
        const commentID = event.params['comment']

        const form = document.getElementById(commentFormId)
        const comment = document.getElementById(commentID)

        form.classList.toggle("hidden")
        comment.classList.toggle("hidden")

    }

    toggleNewReply(event) {
        event.preventDefault();
        event.stopPropagation();

        const replyFormId = event.params['form']
        const replyForm = document.getElementById(replyFormId)

        replyForm.classList.toggle("hidden")
    }

    toggleNewReplyCancel(event) {
        event.preventDefault();
        event.stopPropagation();

        const replyFormId = event.params['form']
        const replyForm = document.getElementById(replyFormId)

        replyForm.firstElementChild.elements[1].value = ''
        
        replyForm.classList.toggle("hidden")
    }

    toggleEditReply(event) {
        event.preventDefault();
        event.stopPropagation();

        const replyFormId = event.params['form']
        const commentID = event.params['comment']

        const replyForm = document.getElementById(replyFormId)
        const comment = document.getElementById(commentID)

        replyForm.classList.toggle("hidden")
        comment.classList.toggle("hidden")
        
    }

    toggleEditReplyCancel(event) {
        event.preventDefault();
        event.stopPropagation();

        const replyFormId = event.params['form']
        const commentID = event.params['comment']

        const replyForm = document.getElementById(replyFormId)
        const comment = document.getElementById(commentID)

        replyForm.classList.toggle("hidden")
        comment.classList.toggle("hidden")   
    }
}
