import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for the EditPokemon Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  /*
   * Regular Stimulus lifecycle methods
   * Learn more at: https://stimulusjs.org/reference/lifecycle-callbacks
   *
   * If you intend to use this controller as a regular stimulus controller as well,
   * make sure any Stimulus lifecycle methods overridden in ApplicationController call super.
   *
   * Important:
   * By default, StimulusReflex overrides the -connect- method so make sure you
   * call super if you intend to do anything else when this controller connects.
  */

  connect () {
    super.connect()
    // add your code here, if applicable
  }

	edit(event) {
		const newName = this.context.scope.element.value;
		this.stimulate("Edit_Pokemon#edit", newName, this.getRoomId());
	}

	editPokedexId(event) {
		const newId = event.target.selectedIndex + 1;
		this.stimulate("Edit_Pokemon#edit_pokedex_id", newId, this.getRoomId());
	}

	displayPokedexIdEdit(event) {
		this.stimulate("Edit_Pokemon#display_pokedex_id_edit", this.getRoomId());
	}

	toggleAlive(event) {
		this.stimulate("Edit_Pokemon#toggle_alive", this.getRoomId());
	}

	toggleBoxed(event) {
		this.stimulate("Edit_Pokemon#toggle_boxed", this.getRoomId());
	}

  /* Reflex specific lifecycle methods.
   *
   * For every method defined in your Reflex class, a matching set of lifecycle methods become available
   * in this javascript controller. These are optional, so feel free to delete these stubs if you don't
   * need them.
   *
   * Important:
   * Make sure to add data-controller="edit-pokemon" to your markup alongside
   * data-reflex="EditPokemon#dance" for the lifecycle methods to fire properly.
   *
   * Example:
   *
   *   <a href="#" data-reflex="click->EditPokemon#dance" data-controller="edit-pokemon">Dance!</a>
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "EditPokemon#dance"
   *
   *   error/noop - the error message (for reflexError), otherwise null
   *
   *   reflexId - a UUID4 or developer-provided unique identifier for each Reflex
   */

  // Assuming you create a "EditPokemon#dance" action in your Reflex class
  // you'll be able to use the following lifecycle methods:

  // beforeDance(element, reflex, noop, reflexId) {
  //  element.innerText = 'Putting dance shoes on...'
  // }

  // danceSuccess(element, reflex, noop, reflexId) {
  //   element.innerText = 'Danced like no one was watching! Was someone watching?'
  // }

  // danceError(element, reflex, error, reflexId) {
  //   console.error('danceError', error);
  //   element.innerText = "Couldn't dance!"
  // }
}
