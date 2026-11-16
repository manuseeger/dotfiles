UNAME := $(shell uname)
.PHONY: help
help: ## Show this help message
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN { \
	 FS = ":.*?## "; \
	 printf "\033[1m%-30s\033[0m %s\n", "TARGET", "DESCRIPTION" \
	} \
	{ printf "\033[32m%-30s\033[0m %s\n", $$1, $$2 }'

bootstrap: nix home-manager ## Install nix and home-manager, switch to current flake

home-manager: ## Install and init home-manager
	nix run .#home-manager -- switch --flake .#$(TARGET)

nix: ## Install nix (lix for Darwin)
ifeq ($(UNAME), Linux)

endif
ifeq ($(UNAME), Darwin)

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
