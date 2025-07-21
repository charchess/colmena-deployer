# Utilise une image de base qui inclut déjà Nix et supporte les flakes.
# nixos/nix est un bon choix.
FROM nixos/nix:latest

# Active les fonctionnalités expérimentales nécessaires pour les flakes et la nouvelle CLI Nix.
RUN mkdir -p /root/.config/nix && \
    echo "experimental-features = nix-command flakes" > /root/.config/nix/nix.conf

# Installe Colmena, Git et OpenSSH en utilisant la nouvelle CLI Nix et les flakes.
# C'est la manière moderne et recommandée de gérer les paquets.
RUN nix profile install nixpkgs#colmena nixpkgs#git nixpkgs#openssh

# Crée un répertoire pour les clés SSH et définit les permissions appropriées.
# C'est ici que vous monterez vos clés SSH privées.
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Définit le répertoire de travail par défaut à l'intérieur du conteneur.
# Votre dépôt de configuration NixOS sera monté ici.
WORKDIR /app

# Commande par défaut à exécuter lorsque le conteneur démarre.
# Démarre un shell bash, à partir duquel vous pourrez lancer vos déploiements.
CMD ["bash"]
