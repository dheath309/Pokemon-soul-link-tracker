import CableReady from "cable_ready"
import consumer from "./consumer"

consumer.subscriptions.create({ channel: "GameChannel", room: getRoomId() }, {
	received(data) {
		if (data.cableReady) CableReady.perform(data.operations)
	}
})

function getRoomId() {
	return window.location.pathname.substr(1);
}
