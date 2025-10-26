#!/bin/bash

# Script rápido para resolver o problema do repositório nvim
# Execute no diretório ~/.config/nvim

set -e

echo "🔧 Resolvendo problema do GitHub para o repositório nvim..."

# Método 1: Tentar com SSH (mais seguro)
echo
echo "📝 Tentando configurar SSH..."

# Gerar chave SSH se não existir
if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "🔑 Gerando chave SSH..."
  ssh-keygen -t ed25519 -C "renato@likwi.com.br" -f ~/.ssh/id_ed25519 -N ""
fi

# Iniciar ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519 2>/dev/null || true

# Mostrar chave pública
echo
echo "🔑 Sua chave SSH pública (copie e adicione no GitHub):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cat ~/.ssh/id_ed25519.pub
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
echo "👉 Vá para: https://github.com/settings/ssh/new"
echo "👉 Cole a chave acima e clique em 'Add SSH key'"
echo

read -p "⏳ Pressione ENTER após adicionar a chave no GitHub..."

# Alterar remote para SSH
echo "🔄 Alterando remote para SSH..."
git remote set-url github git@github.com:renatofagalde/nvim.git

# Testar conexão
echo "🧪 Testando conexão SSH..."
ssh -T git@github.com 2>&1 || true

# Tentar push
echo "🚀 Tentando push..."
if git push -u github main; then
  echo "✅ Push realizado com sucesso via SSH!"
  exit 0
fi

echo
echo "❌ SSH não funcionou, tentando com token..."
echo

# Método 2: Fallback para HTTPS com token
echo "🔐 Configure um Personal Access Token:"
echo "👉 Vá para: https://github.com/settings/tokens"
echo "👉 Clique em 'Generate new token (classic)'"
echo "👉 Marque 'repo' e 'workflow'"
echo "👉 Copie o token gerado"
echo

read -p "🔑 Cole seu token aqui: " -s token
echo

if [ ! -z "$token" ]; then
  # Voltar para HTTPS
  git remote set-url github https://github.com/renatofagalde/nvim.git

  # Configurar credential helper
  git config --global credential.helper store

  # Fazer push com token
  repo_url="https://renatofagalde:$token@github.com/renatofagalde/nvim.git"

  if git push "$repo_url" main; then
    echo "✅ Push realizado com sucesso via HTTPS!"

    # Salvar credenciais
    echo "https://renatofagalde:$token@github.com" >>~/.git-credentials
    echo "💾 Token salvo para uso futuro!"
  else
    echo "❌ Erro no push. Verifique se o repositório existe no GitHub."
  fi
else
  echo "❌ Token vazio. Execute o script novamente."
fi

echo
echo "🎉 Script concluído!"
