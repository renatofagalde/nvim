# 💤 LazyVim + Go – Meu Setup & Atalhos

Uma colinha prática do meu setup **LazyVim** (com LSP) + **Go** (gopls/delve) e um passo‑a‑passo para restaurar exatamente essa configuração, instalar o **SPF (Superfile)** e o **Oxker** (TUI para Docker).

> ⚠️ Este README foi gerado para virar o arquivo inicial do repositório no GitHub. Copie/cole tudo ou use o arquivo baixado.

---

## ✨ Atalhos do dia a dia

| Ação | Modo | Atalho | Observações |
|---|---|---|---|
| **Procurar arquivo por nome** 🔎 | Normal | `<leader>ff` | Telescope → `find_files` |
| **Procurar palavra no projeto** 🧭 | Normal | `<leader>fg` | Telescope → `live_grep` (ripgrep) |
| **Procurar no arquivo (→)** | Normal | `/` | `/palavra` dentro do buffer atual |
| **Procurar no arquivo (←)** | Normal | `?` | `?palavra` dentro do buffer atual |
| **Próxima ocorrência** | Normal | `n` | Repete a última busca |
| **Ocorrência anterior** | Normal | `N` | Repete na direção oposta |
| **Palavra sob o cursor (→)** | Normal | `*` | Busca a palavra atual para frente |
| **Palavra sob o cursor (←)** | Normal | `#` | Busca a palavra atual para trás |
| **Selecionar próxima ocorrência** | Normal/Visual | `gn` | Seleciona o próximo match |
| **Limpar destaque da busca** | Normal | `:noh` | `:nohlsearch` |
| **Terminal flutuante** 🖥️ | Normal | `<leader>t` | Toggle (`toggleterm.nvim`) |
| **Terminal via Telescope** | Normal | `<leader>ft` | Lista/abre terminais |
| **Terminal nativo** | Normal | `:terminal` | Buffer de terminal embutido |
| **Copiar (yank) linha** 📋 | Normal | `yy` | `yiw` palavra; `y$` até fim da linha |
| **Copiar seleção** | Visual | `y` | Selecione com `v`/`V`/`Ctrl+v` e depois `y` |
| **Colar após o cursor** | Normal/Visual | `p` | Cola **após** |
| **Colar antes do cursor** | Normal/Visual | `P` | Cola **antes** |
| **Apagar até o fim da linha** 🧹 | Normal | `d$` (ou `D`) | Remove do cursor até o fim; mantém a quebra de linha |
| **Ir para definição** | Normal | `gd` | LSP |
| **Buscar referências** | Normal | `gr` | LSP; às vezes sugere import relacionado |
| **Ir para implementação** | Normal | `gI` | Útil p/ interfaces (Go) |
| **Ir para declaração** | Normal | `gD` | LSP |
| **Ir para tipo (type definition)** | Normal | `gy` | LSP |
| **Hover (docs)** | Normal | `K` | Documentação do símbolo |
| **Assinatura da função** | Normal | `gK` | Mostra assinatura |
| **Assinatura em Insert** | Insert | `Ctrl+k` | Ajuda de assinatura |
| **Code Action / Autoimport** ✨ | Normal/Visual | `<leader>ca` | `gopls` costuma sugerir **import automático** |
| **Renomear símbolo** | Normal | `<leader>cr` | Renomeia em todos os lugares |
| **Próximo diagnóstico (erro/aviso)** 🚦 | Normal | `]d` | Vai para o próximo diagnóstico do LSP |
| **Diagnóstico anterior** | Normal | `[d` | Vai para o diagnóstico anterior |
| **Diagnostics (Trouble)** | Normal | `<leader>xx` | Abre o **trouble.nvim** com diagnostics |
| **Diagnostics do buffer atual** | Normal | `<leader>xl` | Lista diagnostics **locais** (buffer) |
| **Voltar posição (jumplist)** | Normal | `Ctrl+o` | Volta para onde estava |
| **Avançar posição (jumplist)** | Normal | `Ctrl+i` | Avança no histórico |
| **Voltar último ponto de inserção + Insert** | Normal → Insert | `gi` | Nativo do Vim |
| **Fechar TAB atual** 🗂️ | Normal | `<leader><tab>d` | Fecha a aba atual |
| **Abrir nova TAB** | Normal | `<leader><tab><tab>` | Nova aba |
| **TAB seguinte** | Normal | `<leader><tab>]` | Navega para a próxima |
| **TAB anterior** | Normal | `<leader><tab>[` | Navega para a anterior |
| **Fechar outras TABs** | Normal | `<leader><tab>o` | Mantém só a atual |

> 💡 Dica: se `clipboard=unnamedplus` estiver ativo, os yanks/puts padrão já usam o clipboard do sistema.

---

## 🧱 Restaurar exatamente este setup (LazyVim + Go)

### 1) Pré‑requisitos
- **Neovim** (0.10+ recomendado)
- **Git**
- **Go** (1.21+)
- **curl/wget** (para scripts)

### 2) Estrutura da pasta
Use **~/.config/nvim** como diretório da config. O projeto contém:
```
init.lua           -> carrega config.lazy
lua/config/*.lua   -> options.lua, keymaps.lua, lazy.lua
lazy-lock.json     -> "congela" versões dos plugins (inclui LazyVim)
lua/plugins/*.lua  -> DAP, DAP-Go e afins
```
> Mantendo o **lazy-lock.json**, você fixa as versões exatas dos plugins/da própria LazyVim que estou usando agora.

### 3) Instalar dependências de Go (LSP/Debug)
```bash
# gopls (LSP) e goimports
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

# Delve (debug)
go install github.com/go-delve/delve/cmd/dlv@latest
```

### 4) Instalar LazyVim
A config já **boota** o lazy.nvim e o LazyVim no `init.lua`. No primeiro start do Neovim, os plugins serão instalados automaticamente.
```bash
nvim
# aguarde o Lazy instalar tudo; depois :checkhealth para conferir
```

### 5) Conferir DAP para Go
Abrindo qualquer projeto Go, os comandos de debug funcionam via **nvim-dap** e **nvim-dap-go**.
- **F5** continuar | **F10** over | **F11** into | **F12** out
- `<leader>du` abre/fecha UI do DAP

---

## 📦 Instalar **SPF (Superfile)** – gerenciador de arquivos no terminal

> O executável é `spf` (Superfile).

### Opção A — Script oficial (Linux/macOS)
```bash
bash -c "$(curl -sLo- https://superfile.dev/install.sh)"
# ou
bash -c "$(wget -qO- https://superfile.dev/install.sh)"
```
Para rodar:
```bash
spf
```

### Opção B — Arch Linux (pacote da comunidade)
```bash
sudo pacman -S superfile        # compila a partir do fonte
# ou a versão git mais recente:
yay -S superfile-git
```

> Dica: usar **Nerd Font** melhora os ícones/visual do Superfile.

---

## 🐳 Instalar **Oxker** – TUI para Docker

### Opção A — Cargo
```bash
cargo install oxker
```

### Opção B — Arch Linux (AUR)
```bash
paru -S oxker
```

### Opção C — Binário pré‑compilado (x86_64 Linux)
```bash
wget https://www.github.com/mrjackwills/oxker/releases/latest/download/oxker_linux_x86_64.tar.gz \
  && tar xzvf oxker_linux_x86_64.tar.gz oxker \
  && install -Dm755 oxker -t "${HOME}/.local/bin" \
  && rm oxker_linux_x86_64.tar.gz oxker
```

### Opção D — Executar via Docker
```bash
docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --pull=always ghcr.io/mrjackwills/oxker
```

Para abrir:
```bash
oxker
```

---

## 🧰 Criar o repositório no GitHub (com este README)

> Substitua `SEU_USUARIO` e `meu-lazyvim-setup` como preferir.

```bash
# 1) Crie a pasta do projeto (se ainda não existir)
mkdir -p ~/projects/meu-lazyvim-setup && cd ~/projects/meu-lazyvim-setup

# 2) Copie sua config atual do Neovim
rsync -av --delete ~/.config/nvim/ ./nvim/

# 3) Adicione este README
# (se você está lendo no GitHub, já está aqui; caso contrário salve o arquivo como README.md)
# echo "...conteúdo..." > README.md

# 4) Git init + primeiro commit
git init -b main
git add .
git commit -m "✨ feat: LazyVim + Go setup + atalhos (README)"

# 5) Crie o repositório no GitHub (site) e pegue a URL SSH/HTTPS
git remote add origin git@github.com:SEU_USUARIO/meu-lazyvim-setup.git  # (ou HTTPS)
git push -u origin main
```

> Se quiser reaproveitar em outra máquina: clone o repo, copie `nvim/` para `~/.config/nvim`, e rode `nvim`.

---

## 🧾 Licença

Use como quiser. Sugestão: **Apache-2.0** ou **MIT**.

---

## 🙌 Contribuições

PRs são bem‑vindos com mais atalhos, extras do LazyVim, temas, etc.
