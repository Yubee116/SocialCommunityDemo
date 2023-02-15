import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }
  toggleForm(event){
    event.preventDefault();
    event.stopPropagation();

    const postFormId = event.params['form'] 
    const postID = event.params['post']

    const form = document.getElementById(postFormId)
    const post = document.getElementById(postID)

    form.classList.toggle("hidden")
    post.classList.toggle("hidden")
  }

  toggleFormCancel(event) {
    event.preventDefault();
    event.stopPropagation();

    const postFormId = event.params['form'] 
    const postID = event.params['post']

    const form = document.getElementById(postFormId)
    const post = document.getElementById(postID)

    form.classList.toggle("hidden")
    post.classList.toggle("hidden")
}
}
