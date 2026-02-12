# Scout 2.0 + Nav2 (ROS 2 Humble) — Simulação Reprodutível (Docker ou Nativo)

Este repositório fornece um ambiente **pronto para executar** a simulação do **AgileX Scout 2.0** com **Nav2 (ROS 2 Humble)** e visualização via **RViz**, oferecendo duas formas de execução:

- ✅ **Opção A (Recomendada): Docker** — reprodutível, isolado, fácil de rodar em qualquer máquina.
- ✅ **Opção B: Ubuntu 22.04 + ROS 2 Humble nativo** — para quem prefere instalar tudo localmente.

O ambiente de simulação e os pacotes de navegação foram baseados no repositório público:

**AIRLab POLIMI — scout_nav2:**  
https://github.com/AIRLab-POLIMI/scout_nav2

---

## 📦 Estrutura do repositório

- `Dockerfile` — imagem ROS 2 Humble Desktop + dependências.
- `docker-compose.yml` — configuração do container com display/X11.
- `run_scout.sh` — script para subir o container e abrir um terminal dentro dele.
- `ws/` — workspace ROS 2 (colcon):
  - `ws/src/scout_nav2` — pacotes do Scout/Nav2 (baseado no repositório do AIRLab).

---

## ✅ Requisitos

### Para Docker (Opção A)
- Ubuntu (recomendado 22.04) ou distro compatível
- Docker Engine + Docker Compose
- Suporte a interface gráfica X11 (para abrir RViz/Gazebo)

### Para Nativo (Opção B)
- Ubuntu 22.04
- ROS 2 Humble instalado
- Dependências do Nav2 + Gazebo/Ignition (conforme abaixo)

---

# ✅ OPÇÃO A — Rodar com Docker (RECOMENDADO)

## A.1) Instalar Docker (Ubuntu)

```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
