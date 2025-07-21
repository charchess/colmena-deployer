    # Utilise une image de base qui inclut déjà Nix.
    # nixos/nix est un bon choix car il est optimisé pour les opérations Nix.
    FROM nixos/nix:latest

    # Met à jour les paquets et installe les dépendances nécessaires.
    # bash est utile pour les scripts, git pour cloner votre dépôt de configuration,
    # openssh-client pour les connexions SSH vers vos machines cibles.
    RUN nix-channel --update && \
        nix-env -iA nixpkgs.bash nixpkgs.git nixpkgs.openssh && \
        nix-env -f '<nixpkgs>' -iA nixpkgs.colmena

    # Crée un répertoire pour les clés SSH et les permissions appropriées.
    # C'est ici que vous monterez vos clés SSH privées.
    RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

    # Définit le répertoire de travail par défaut à l'intérieur du conteneur.
    # C'est ici que votre dépôt de configuration sera monté.
    WORKDIR /app

    # Commande par défaut à exécuter lorsque le conteneur démarre.
    # Ici, nous laissons le conteneur démarrer sur un shell bash.
    # Vous exécuterez vos commandes 'colmena apply' manuellement ou via un script.
    CMD ["bash"]

