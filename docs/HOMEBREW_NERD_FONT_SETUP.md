# Instalando Homebrew e Nerd Font (MesloLGS) no macOS

Este guia resolve o problema dos ícones do **Powerlevel10k** aparecerem como `?` no terminal. Isso acontece porque a fonte padrão do Terminal/iTerm2 não possui os glifos necessários. A solução é instalar a fonte **MesloLGS NF** via Homebrew Cask.

---

## Pré-requisitos

- macOS 12 (Monterey) ou superior
- Conexão com a internet
- Acesso ao Terminal (`/Applications/Utilities/Terminal.app`) ou iTerm2

---

## Passo 1 – Verificar se você tem direitos de administrador

Antes de instalar o Homebrew, confirme que sua conta de usuário possui privilégios de administrador:

```bash
groups $(whoami) | grep -q admin && echo "✅ Você é administrador" || echo "❌ Você NÃO é administrador"
```

Se o resultado for `❌ Você NÃO é administrador`, consulte a seção [Sem senha de administrador](#sem-senha-de-administrador) ao final deste documento.

---

## Passo 2 – Instalar o Homebrew

1. Abra o **Terminal** (ou iTerm2).
2. Cole o comando oficial de instalação do Homebrew:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. O script exibirá uma lista de arquivos/diretórios que serão criados e pedirá confirmação. **Pressione `Enter`** para continuar.

4. Em seguida, o sistema solicitará sua senha de administrador:

   ```
   Password:
   ```

   > **Atenção:** ao digitar a senha, o cursor **não se move** e nenhum caractere é exibido — isso é normal e esperado no macOS. Digite sua senha normalmente e pressione `Enter`.

5. O processo de instalação será iniciado e pode levar alguns minutos. Aguarde até ver a mensagem:

   ```
   ==> Installation successful!
   ```

6. Siga as instruções exibidas ao final do script para adicionar o Homebrew ao seu `PATH`. Normalmente são dois comandos parecidos com:

   ```bash
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

   > Em Macs com processador Intel o caminho pode ser `/usr/local/bin/brew` em vez de `/opt/homebrew/bin/brew`. Utilize exatamente os comandos exibidos pelo instalador.

7. Verifique a instalação:

   ```bash
   brew --version
   ```

   A saída deve ser algo como `Homebrew 4.x.x`.

---

## Passo 3 – Instalar a Nerd Font MesloLGS NF

Com o Homebrew instalado, execute:

```bash
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

> **Nota:** O tap `homebrew/cask-fonts` pode já estar integrado ao core em versões mais recentes do Homebrew. Se receber um aviso de que o tap foi deprecado, ignore-o — o `install` a seguir ainda funcionará.

Aguarde a conclusão. Ao finalizar, a fonte estará disponível no sistema.

---

## Passo 4 – Selecionar a fonte no Terminal ou iTerm2

### Terminal (app nativo do macOS)

1. Abra o **Terminal**.
2. Acesse **Terminal → Preferências** (ou `⌘,`).
3. Clique na aba **Perfis**.
4. Selecione o perfil que você usa (geralmente "Basic" ou "Pro").
5. Clique na aba **Texto**.
6. Em **Fonte**, clique em **Alterar…**.
7. Pesquise por `MesloLGS NF` e selecione a fonte. Recomenda-se tamanho **13** ou **14**.
8. Feche as preferências e **reabra** uma janela do Terminal.

### iTerm2

1. Abra o **iTerm2**.
2. Acesse **iTerm2 → Preferences** (ou `⌘,`).
3. Vá em **Profiles → Text**.
4. Em **Font**, clique no botão de fonte atual.
5. Pesquise por `MesloLGS NF`, selecione-a e ajuste o tamanho.
6. Feche as preferências e **reabra** uma janela do iTerm2.

---

## Passo 5 – Verificar o resultado

Após reiniciar o terminal com a nova fonte, os ícones do Powerlevel10k devem aparecer corretamente. Se precisar reconfigurar o tema, execute:

```bash
p10k configure
```

---

## Solução de Problemas

### `Sorry, try again.`

Esta mensagem aparece quando a senha digitada está incorreta. Causas comuns:

- **Caps Lock ativado** — verifique se a tecla Caps Lock está desligada.
- **Senha digitada incorretamente** — lembre-se de que nenhum caractere é exibido enquanto você digita.
- **Conta sem privilégios de sudo** — se o erro persistir após três tentativas corretas, sua conta pode não ter permissão de `sudo`. Consulte a seção abaixo.

O sistema permite **3 tentativas** antes de cancelar a operação. Caso isso ocorra, basta executar o comando de instalação novamente.

### Sem senha de administrador

Se você não tiver a senha de administrador ou sua conta não for administradora:

1. **Instale o Homebrew no diretório do usuário (sem sudo):**

   ```bash
   git clone https://github.com/Homebrew/brew ~/.homebrew
   eval "$(~/.homebrew/bin/brew shellenv)"
   brew update --force --quiet
   chmod -R go-w "$(brew --prefix)/share/zsh"
   ```

   Adicione ao seu `~/.zprofile` para persistir:

   ```bash
   echo 'eval "$(~/.homebrew/bin/brew shellenv)"' >> ~/.zprofile
   ```

2. **Instale a fonte manualmente:**
   - Acesse <https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k>
   - Baixe os quatro arquivos `.ttf` listados:
     - `MesloLGS NF Regular.ttf`
     - `MesloLGS NF Bold.ttf`
     - `MesloLGS NF Italic.ttf`
     - `MesloLGS NF Bold Italic.ttf`
   - Dê dois cliques em cada arquivo e clique em **Instalar Fonte**.
   - Reinicie o Terminal/iTerm2 e configure a fonte conforme o [Passo 4](#passo-4--selecionar-a-fonte-no-terminal-ou-iterm2).

---

## Referências

- [Homebrew – documentação oficial](https://brew.sh)
- [Powerlevel10k – fontes recomendadas](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)
- [Homebrew Cask Fonts](https://github.com/Homebrew/homebrew-cask-fonts)
