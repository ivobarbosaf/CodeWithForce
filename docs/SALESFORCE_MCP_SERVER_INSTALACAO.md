# Instruções para Instalação do Salesforce MCP Server

## Objetivo

Criar um guia simples e claro para instalar o Salesforce MCP Server, permitindo integração de agentes de IA com um org Salesforce.

---

## O que é o Salesforce MCP Server?

O Salesforce MCP Server é uma implementação do Model Context Protocol (MCP) que permite a integração entre orgs Salesforce e agentes de IA. O MCP é um padrão open-source que possibilita que aplicações de IA e agentes se conectem de forma segura e dinâmica a ferramentas e dados, sem necessidade de integrações customizadas para cada sistema.

Com o Salesforce DX MCP Server, você pode:

- Executar operações específicas do Salesforce via linguagem natural
- Consultar dados do Salesforce
- Fazer deploy de metadados
- Executar testes
- Integrar com IDEs como VS Code, GitHub Copilot, Claude, e outros

---

## Pré-requisitos

Antes de começar, você precisa ter:

- **Node.js e npm** instalados
- **Salesforce CLI** instalado
- **Visual Studio Code** ou outro IDE compatível
- **Org Salesforce** autenticado e preferencialmente definido como default

---

## Passo a Passo

### 1. Instalar Node.js e npm

Node.js é necessário para executar o MCP Server.

**Verificar se já estão instalados:**

```bash
node -v
npm -v
```

**Se não estiverem instalados:**

- Acesse: https://nodejs.org
- Baixe e instale a versão LTS (Long Term Support)
- Após a instalação, verifique novamente com os comandos acima

---

### 2. Instalar Salesforce CLI

O Salesforce CLI é essencial para autenticar e gerenciar suas orgs.

**Download:**

- Acesse: https://developer.salesforce.com/tools/sfdxcli
- Baixe e instale a versão apropriada para seu sistema operacional

**Verificar instalação:**

```bash
sf --version
```

---

### 3. Autenticar e Definir Org Default

**Autenticar um org Salesforce:**

```bash
sf org login web --set-default
```

Este comando abrirá uma janela do navegador para você fazer login na sua org Salesforce.

**Ou, para listar orgs já autenticados e definir um como default:**

```bash
# Listar todos os orgs autenticados
sf org list

# Definir um org específico como default
sf config set target-org=<username_ou_alias>
```

**Exemplo:**

```bash
sf config set target-org=meuorg@example.com
```

---

### 4. Instalar o Salesforce MCP Server

O Salesforce DX MCP Server está disponível como um pacote npm oficial.

**Opção A: Instalação via npx (recomendado)**

Você pode executar o servidor diretamente sem instalação global:

```bash
npx -y @salesforce/mcp --orgs <SEU_ORG_ALIAS> --toolsets all
```

**Exemplo:**

```bash
npx -y @salesforce/mcp --orgs MyOrg --toolsets orgs,metadata,data,users
```

**Opção B: Instalação global**

```bash
npm install -g @salesforce/mcp
```

---

### 5. Configurar MCP Server no VS Code

Para integrar o MCP Server com o VS Code, você precisa criar um arquivo de configuração.

**Criar arquivo `.vscode/mcp.json` na raiz do seu projeto:**

```json
{
  "servers": {
    "Salesforce DX": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@salesforce/mcp",
        "--orgs",
        "<SEU_ORG_ALIAS>",
        "--toolsets",
        "all"
      ]
    }
  }
}
```

**Exemplo com configurações específicas:**

```json
{
  "servers": {
    "Salesforce DX": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@salesforce/mcp",
        "--orgs",
        "MyOrg",
        "--toolsets",
        "orgs,metadata,data,users"
      ]
    }
  }
}
```

**Toolsets disponíveis:**

- `orgs` - Operações relacionadas a orgs
- `metadata` - Deploy e retrieve de metadados
- `data` - Operações de dados (SOQL, DML)
- `users` - Gerenciamento de usuários
- `all` - Todos os toolsets acima

---

### 6. Testar a Instalação

**Verificar se o MCP Server está funcionando:**

```bash
npx @salesforce/mcp --orgs <SEU_ORG_ALIAS> --toolsets all
```

O servidor deve iniciar sem erros. Você pode testar executando comandos via agentes de IA compatíveis com MCP, como:

- GitHub Copilot no VS Code
- Claude Desktop
- Cursor IDE
- Outros agentes compatíveis com MCP

---

## Configurações Avançadas

### Configurar Múltiplos Orgs

Você pode configurar o MCP Server para trabalhar com múltiplos orgs:

```json
{
  "servers": {
    "Salesforce Dev": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@salesforce/mcp", "--orgs", "DevOrg", "--toolsets", "all"]
    },
    "Salesforce Production": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@salesforce/mcp",
        "--orgs",
        "ProdOrg",
        "--toolsets",
        "metadata,data"
      ]
    }
  }
}
```

### Limitar Toolsets por Segurança

Por questões de segurança, é recomendado expor apenas os toolsets necessários:

```json
{
  "servers": {
    "Salesforce DX": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@salesforce/mcp",
        "--orgs",
        "MyOrg",
        "--toolsets",
        "orgs,data"
      ]
    }
  }
}
```

---

## Solução de Problemas

### Erro: "sf: command not found"

**Solução:** Reinstale o Salesforce CLI e certifique-se de que está no PATH do sistema.

### Erro: "No default org found"

**Solução:** Execute `sf org login web --set-default` para autenticar e definir um org default.

### MCP Server não inicia

**Verificar:**

1. Node.js está instalado e atualizado (`node -v`)
2. Org está autenticado (`sf org list`)
3. Configuração do `mcp.json` está correta
4. Tentar executar manualmente: `npx @salesforce/mcp --orgs <ORG> --toolsets all`

### Permissões Insuficientes

**Solução:** Certifique-se de que o usuário autenticado tem as permissões necessárias no org Salesforce.

---

## Boas Práticas

1. **Segurança em Primeiro Lugar:** Exponha apenas os toolsets necessários para cada agente
2. **Use Aliases:** Configure aliases para seus orgs para facilitar o gerenciamento
3. **Audite Ações:** Utilize políticas organizacionais (como recursos do Agentforce) para rastrear e auditar ações dos agentes
4. **Mantenha Atualizado:** Atualize regularmente o MCP Server e revise suas limitações
5. **Teste em Sandbox:** Sempre teste configurações em sandboxes antes de usar em produção

---

## Recursos Adicionais

- [Salesforce Developer Guide](https://developer.salesforce.com/blogs/2025/06/introducing-mcp-support-across-salesforce)
- [GitHub do MCP Server](https://github.com/salesforcecli/mcp)
- [Documentação do Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/)
- [Model Context Protocol - Documentação Oficial](https://modelcontextprotocol.io/)

---

## Exemplos de Uso

Após configurar o MCP Server, você pode usar comandos em linguagem natural nos seus agentes de IA:

- "Liste todos os Accounts criados esta semana"
- "Faça deploy do componente MyApexClass para o org"
- "Execute os testes da classe MyTestClass"
- "Crie um novo Lightning Web Component chamado myComponent"
- "Mostre os campos customizados do objeto Opportunity"

---

## Conclusão

Com o Salesforce MCP Server instalado e configurado, você agora pode integrar seus orgs Salesforce com agentes de IA, permitindo automação e consultas mais inteligentes através de linguagem natural.

Para mais informações e atualizações, consulte regularmente a documentação oficial da Salesforce e o repositório do GitHub do MCP Server.
