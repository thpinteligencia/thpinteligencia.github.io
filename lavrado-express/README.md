# Instruções de Publicação da Landing Page

Criamos uma landing page moderna, responsiva e de alta conversão para o **Lavrado Express** na pasta `landing/`.

Esta pasta contém:
- `index.html`: Estrutura HTML5 semântica e moderna.
- `style.css`: Estilização premium com gradientes mesh, tipografia Outfit/Inter e layout responsivo.

Como o repositório principal é privado e possui código confidencial (propriedade intelectual da empresa), siga os passos abaixo para publicar a landing page de forma gratuita no GitHub Pages **sem expor nenhum código**:

---

## Passo a Passo para Publicar (Forma B)

### Passo 1: Criar o Repositório no GitHub
1. Acesse o GitHub e crie um novo repositório público na sua organização/conta.
2. Nomeie o repositório exatamente como: **`thpinteligencia.github.io`**
3. Certifique-se de que ele é **Público** (não privado).
4. Deixe desmarcado "Initialize this repository with a README" (deixe vazio).

### Passo 2: Inicializar e Subir os Arquivos
No terminal da sua máquina, execute os seguintes comandos para clonar o novo repositório vazio e mover as configurações:

```bash
# 1. Entre no diretório da landing page criada
cd "/home/hiago/Workspace/THP/Lavrado Express/landing"

# 2. Inicialize o repositório git localmente nesta pasta
git init

# 3. Adicione todos os arquivos da pasta
git add index.html style.css

# 4. Crie o primeiro commit
git commit -m "feat: init landing page"

# 5. Renomeie a branch padrão para main
git branch -M main

# 6. Adicione o remote do seu novo repositório do GitHub usando o host correto (github-thp)
git remote add origin git@github-thp:thpinteligencia/thpinteligencia.github.io.git

# 7. Envie os arquivos para o GitHub
git push -u origin main
```

---

## Resultado
Assim que o upload for concluído, o GitHub ativará automaticamente o GitHub Pages para o repositório `thpinteligencia.github.io`.

Em menos de 1 minuto, sua nova landing page simples e gratuita estará no ar no endereço raiz:
👉 **[https://thpinteligencia.github.io/](https://thpinteligencia.github.io/)**
