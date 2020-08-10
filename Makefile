
run: build proxy-secret proxy-multi.conf
	docker-compose up --build -d

stop:
	docker-compose down

build:
	docker build -t mtproxy .

proxy-secret:
	curl --fail -s https://core.telegram.org/getProxySecret -o proxy-secret

.PHONY: proxy-multi.conf
proxy-multi.conf:
	curl --fail -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf

clean:
	rm -v proxy-secret
	rm -v proxy-multi.conf

reconfigure: proxy-multi.conf stop run

# vi:syntax=make
