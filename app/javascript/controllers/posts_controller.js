import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello Yubee")
  }
  toggleForm(event){
    console.log('clicked edit button');
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
