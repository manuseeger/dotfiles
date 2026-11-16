UNAME := $(shell uname)
.PHONY: help bootstrap home-manager nix-darwin nix nix.linux nix.darwin switch
help: ## Show this help message
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN { \
	 FS = ":.*?## "; \
	 printf "\033[1m%-30s\033[0m %s\n", "TARGET", "DESCRIPTION" \
	} \
	{ printf "\033[32m%-30s\033[0m %s\n", $$1, $$2 }'

bootstrap: nix nix-darwin home-manager ## Install nix and home-manager, switch to current flake

home-manager: ## Install and init home-manager
	nix run .#home-manager -- switch --flake .#$(TARGET)

nix-darwin: ## Install nix-darwin (Darwin only)
ifeq ($(UNAME), Darwin)
	sudo mkdir -p /etc/nix-darwin
	sudo chown $$(id -nu):$$(id -ng) /etc/nix-darwin
	cd /etc/nix-darwin; nix flake init -t nix-darwin/nix-darwin-26.05 && \
		sed -i '' "s/simple/$$(scutil --get LocalHostName)/" flake.nix && \
		sudo nix run nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch
endif

nix: ## Install nix (lix for Darwin)
ifeq ($(UNAME), Linux)
nix: nix.linux
endif
ifeq ($(UNAME), Darwin)
nix: nix.darwin
endif

nix.linux:
	curl -L https://nixos.org/nix/install | sh -s -- --daemon
nix.darwin:
	curl -sSf -L https://install.lix.systems/lix -o /tmp/lix-setup.sh
	sh /tmp/lix-setup.sh  install
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	rm /tmp/lix-setup.sh

switch: ## Switch to current flake
	home-manager switch --flake .#$(TARGET)

.DEFAULT_GOAL: help
