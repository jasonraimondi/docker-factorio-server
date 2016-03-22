build:
	docker build -t stanislavb/factorio-server .

run:
	docker run -it \
		-p "34197:34197/udp" \
		-v "$(PWD)/saves:/opt/factorio/saves" \
		stanislavb/factorio-server
