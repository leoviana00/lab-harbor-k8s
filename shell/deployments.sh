#!/bin/bash

config_kubectl() {
    echo "Setting Kubeconfig ..."
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    kubectl get nodes 
}

install_helm() {
    echo "Installing Helm ..."
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    echo "Helm is running!"
}

setup_istio() {
    echo "Setting up Istio ..."
    curl -L https://istio.io/downloadIstio | sh -
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.16.2 TARGET_ARCH=x86_64 sh -
    cd istio-1.16.2
    export PATH=$PWD/bin:$PATH
    istioctl install --set profile=default -y
    kubectl label namespace default istio-injection=enabled
    echo "Istio is running!"
}

setup_argocd() {
    echo "Setting up argocd ..."
    kubectl create namespace argocd
    kubectl label namespace argocd istio-injection=enabled --overwrite
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    echo "Argocd is running!"
}


config_kubectl
install_helm
setup_istio
setup_argocd
