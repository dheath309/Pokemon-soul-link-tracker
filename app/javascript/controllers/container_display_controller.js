import ApplicationController from './application_controller'

export default class extends ApplicationController {

  connect () {
    super.connect()
  }

  	toggleBoxedContainer(event) {
		const boxedContainers = document.querySelectorAll(".boxed-pokemon-container");	
		boxedContainers.forEach((container) => {
			container.style.display = container.style.display == "none" ? "block" : "none";
		})
	}

	toggleDeadContainer(event) {
		const deadContainers = document.querySelectorAll(".dead-pokemon-container");	
		deadContainers.forEach((container) => {
			container.style.display = container.style.display == "none" ? "block" : "none";
		})

	}
}
