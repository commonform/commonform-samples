forms=$(wildcard *.commonform)
json=$(forms:commonform=json)
COMMONFORM=node_modules/.bin/commonform
LISPY=node_modules/.bin/lispy-json

all: $(json)

$(COMMONFORM):
	npm i --save commonform-cli@0.10.x

$(LISPY):
	npm i --save lispy-json

%.json: %.commonform $(COMMONFORM) $(LISPY)
	$(COMMONFORM) render --format native < $< | $(LISPY) > $@

.PHONY: clean share lint

clean:
	rm -rf $(json)

share: $(json)
	for json in $(json); do \
		commonform share < $$json; \
	done

lint: $(json) $(COMMONFORM)
	for json in $(json); do \
		echo $$json ; \
		$(COMMONFORM) lint < $$json | sort -u ; \
		echo ; \
	done
