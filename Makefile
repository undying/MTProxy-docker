
run: build proxy-secret proxy-multi.conf
	docker-compose up --build -d

stop:
	docker-compose down

build:
	docker build -t mtproxy .

proxy-secret:
	curl -s https://core.telegram.org/getProxySecret -o proxy-secret

proxy-multi.conf:
	curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf

clean: stop
	rm -v proxy-secret
	rm -v proxy-multi.conf

# vi:syntax=make
