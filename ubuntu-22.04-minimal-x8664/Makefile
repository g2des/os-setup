


CODE_D := ~/code
OSS_D := $(CODE_D)/oss
STUDY_D := $(CODE_D)/studylab
DEVCONTAINERS_D := $(OSS_D)/templates

URL_DEVCONTAINERS := "https://github.com/microsoft/vscode-dev-containers.git"
.ONESHELL:

apt-update:
	sudo apt-get update && sudo apt-get upgrade -y

apt-install: apt-update
	sudo apt-get install -y vim \
							git \
							ca-certificates \
    						curl \
    						gnupg \
							gnome-tweaks
snap-install:
	snap install spotify \
				sublime-text --classic 

drivers-add:
	sudo ubuntu-drivers autoinstall
vscode-setup: 
	snap install code --classic
		
vscode-add-extensions: vscode-setup
	for extension in ms-vscode-remote.remote-containers \
			vscodevim.vim \
			GitHub.vscode-pull-request-github \
			esbenp.prettier-vscode \
			mikestead.dotenv \
			PKief.material-icon-theme \
			ms-azuretools.vscode-docker \
			ms-kubernetes-tools.vscode-kubernetes-tools \
			redhat.vscode-yaml \
			bungcip.better-toml \
			ms-vscode.makefile-tools; \
	do \
		code --install-extension $$extension ; \
	done
	echo "Installation completed
	code --list-extensions 

vscode-add-devcontainers: folder-structure
	git clone  $(URL_DEVCONTAINERS) --no-checkout $(DEVCONTAINERS_D) 
	cd $(DEVCONTAINERS_D)
	git sparse-checkout init 
	git sparse-checkout set containers/
	git sparse-checkout list
	git sparse-checkout reapply
	git checkout main
	ls -la
	sudo ln -s /usr/bin/stat /usr/bin/lstat

vscode-remove-devcontainers:
	rm -rf $(DEVCONTAINERS_D)

logout-user : 
	read -p "Logout to enable access to docker to this user?[Y/n] " yn
	case $$yn in \
		[Yy]* ) pkill -u $$USERNAME;; \
		[Nn]* ) echo "Manually logout later to enable docker run for $$USERNAME";; \
		* ) echo  "Please answer yes or no.";; \
	esac 

minikube-add-url:
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube
	rm minikube-linux-amd64
	minikube start
	minikube stop


docker-priv-add-src-list:
	sudo mkdir -m 0755 -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
	"deb [arch="$$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	"$$(. /etc/os-release && echo "$$VERSION_CODENAME")" stable" | \
	sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
	
docker-priv-add-package:
	sudo apt-get install --yes  docker-ce \
								docker-ce-cli \
								containerd.io \
								docker-buildx-plugin \
								docker-compose-plugin


docker-priv-test-package:
	which docker
	sudo docker run hello-world

docker-priv-add-user:
	sudo groupadd -f docker
	sudo usermod -aG docker $$USER
	logout-user	

docker-add-apt: docker-priv-add-src-list apt-update docker-priv-add-package docker-priv-test-package docker-priv-add-user

docker-remove-apt: 
	sudo rm /etc/apt/sources.list.d/docker.list /etc/apt/keyrings/docker.gpg
	sudo apt-get remove docker docker-engine docker.io containerd runc


docker-remove-snap:
	sudo snap remove docker
	sudo groupdel -f docker

docker-setup-snap:
	sudo snap install docker
	sudo groupadd -f docker
	sudo usermod -aG docker $$USER
	logout-user	

keyboard-macos-backup:
	dconf dump / > ./user.conf
	ls -la ./user.conf

keyboard-macos-restore:
	dconf load / < ./user.conf

folder-structure:
	mkdir -p $(OSS_DIR) $(STUDY_D)