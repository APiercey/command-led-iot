watch_home:
	mosquitto_sub -h localhost -t "data"

watch_command:
	mosquitto_sub -h localhost -t "command"

set_luminosity_to_100:
	curl --data '{"luminosity": "100"}' -H "content-type: application/json" -X PATCH http://localhost:4000/api/set_luminosity

set_luminosity_to_50:
	curl --data '{"luminosity": "50"}' -H "content-type: application/json" -X PATCH http://localhost:4000/api/set_luminosity

set_luminosity_to_0:
	curl --data '{"luminosity": "0"}' -H "content-type: application/json" -X PATCH http://localhost:4000/api/set_luminosity

