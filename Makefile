.PHONY: help
help: ## Show this help message
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN { \
	 FS = ":.*?## "; \
	 printf "\033[1m%-30s\033[0m %s\n", "TARGET", "DESCRIPTION" \
	} \
	{ printf "\033[32m%-30s\033[0m %s\n", $$1, $$2 }'

bootstrap: lix darwin-nix home-manager ## Boostrap lix, nix-darwin, and home-manager
home-manager: ## Install home-manager
	nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
	nix-channel --update
	nix run home-manager/release-26.05 -- init --switch .$#$(TARGET)

nix-darwin: ## Install nix-darwin
	sudo mkdir -p /etc/nix-darwin
	sudo chown $$(id -nu):$$(id -ng) /etc/nix-darwin
	cd /etc/nix-darwin; nix flake init -t nix-darwin/nix-darwin-26.05 && \
		sed -i '' "s/simple/$$(scutil --get LocalHostName)/" flake.nix && \
		sudo nix run nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch

lix: ## Install lix
	curl -sSf -L https://install.lix.systems/lix -o /tmp/lix-setup.sh
	sh /tmp/lix-setup.sh  install
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	rm /tmp/lix-setup.sh

switch: ## Switch to current flake
	home-manager switch $$(pwd) --flake .$#$(TARGET)


.DEFAULT_GOAL: help
