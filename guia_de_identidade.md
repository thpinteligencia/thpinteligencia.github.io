# Guia de Identidade Visual - THP DeepTech & Systems

Este documento serve como referência oficial de estilo do site, contendo Design Tokens (variáveis CSS), tipografia e regras de layout (Astro + CSS Customizado). 

---

## 🤖 System Prompt (Instruções para Agentes de IA)

**Se você é uma Inteligência Artificial (LLM) atuando neste repositório para gerar ou alterar páginas HTML, você DEVE seguir rigidamente estas regras de composição:**

1. **PROIBIDO Tailwind/Bootstrap:** O projeto utiliza CSS customizado puro. Não gere classes utilitárias (ex: `flex`, `justify-center`, `text-xl`). Crie classes semânticas e utilize os Design Tokens (variáveis) para estilizá-las.
2. **Cores via Variáveis:** Nunca utilize códigos HEX ou RGB (`#fff`, `#000`) hardcoded no CSS para fundos e textos estruturais. Você deve *sempre* usar as variáveis `var(--color-...)` definidas na seção 2 deste guia, para garantir o suporte automático ao Light Mode.
3. **Container Obrigatório:** Todo o conteúdo estrutural da página deve estar contido dentro de uma `<div class="app-container">` para respeitar as margens e a largura máxima de 1200px.
4. **Fundos DeepTech (Mesh):** Qualquer nova página completa deve conter os elementos de fundo logo após a abertura da tag `<body>`:
   ```html
   <div class="mesh-bg"></div>
   <div class="mesh-bg-accent"></div>
   ```
5. **SVGs Inline:** Para ilustrações abstratas e ícones menores (estrelas, badges), utilize `<svg>` inline ao invés de imagens rasterizadas, aplicando classes para controlar cores via CSS.
6. **Efeito Glassmorphism:** Elementos em destaque (cards) usam fundos translúcidos e `backdrop-filter`. Sempre referencie o estilo base documentado na seção "Cartões".

---

## 1. Tipografia

O projeto carrega localmente duas fontes do Google Fonts:
* **Títulos e Destaques (Headings):** `Outfit` (Pesos: 400, 500, 600, 700, 800)
* **Textos Gerais (Body):** `Inter` (Pesos: 300, 400, 500, 600, 700)

**Variáveis CSS correspondentes:**
```css
--font-heading: "Outfit", "Inter", system-ui, sans-serif;
--font-body: "Inter", system-ui, sans-serif;
```

---

## 2. Paleta de Cores (Design Tokens)

O tema base é o **Dark Mode**. O modo claro inverte essas variáveis automaticamente via `data-theme="light"`.

### Cores Base (Fundos e Bordas)
* `--color-bg`: Fundo principal (`#0a1e3f`).
* `--color-surface`: Fundo de cartões/elementos isolados (`rgba(18, 58, 115, 0.45)`).
* `--color-surface-hover`: Hover de cartões (`rgba(44, 94, 168, 0.35)`).
* `--color-border`: Bordas padrão e separadores (`rgba(201, 212, 224, 0.15)`).
* `--color-border-hover`: Hover de bordas (`rgba(201, 212, 224, 0.3)`).

### Cores de Texto
* `--color-text-primary`: Textos principais e títulos (`#f8fbfd`).
* `--color-text-secondary`: Parágrafos, legendas e textos auxiliares (`#c9d4e0`).

### Cores de Destaque (Acentos da Marca)
* `--color-accent-orange`: Laranja THP - Usado para pontos focais (`#f68b23`).
* `--color-accent-blue`: Azul THP (`#2c5ea8`).
* `--color-accent-purple`: Roxo - Usado para temas relacionados à IA (`#a78bfa`).

### Gradientes
* `--gradient-brand`: Gradiente para botões CTAs principais (`linear-gradient(135deg, #f68b23 0%, #d97706 100%)`).
* `--gradient-text`: Para títulos "Hero" grandes (`linear-gradient(135deg, #f8fbfd 0%, #38bdf8 50%, #f68b23 100%)`).
  * *Uso HTML:* `<span class="gradient-text">Texto aqui</span>`

---

## 3. Light Mode (Modo Claro)

O modo claro é ativado inserindo `data-theme="light"` na tag raiz. As variáveis base (`--color-bg`, `--color-surface`, `--color-text-*`) são sobrescritas automaticamente no `custom.css`. 

**Regra para IAs:** Caso você precise criar um novo componente CSS que exige um estilo opaco específico no modo claro, faça a sobrescrita utilizando:
```css
[data-theme="light"] .sua-nova-classe {
  /* sobrescritas de cores e bordas */
}
```

---

## 4. Estruturas HTML/CSS Comuns (Templates)

### 4.1 Badges (Pílulas)
Usados para classificar conteúdo (áreas de atuação, tags de tecnologia).
```html
<span class="section-badge-pill">Nome da Área</span>
<span class="status-badge status-stable">Ativo</span>
```

### 4.2 Cartões (Glassmorphism)
Estrutura base para qualquer "Card" novo criado no site.
```css
.seu-novo-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border-radius: 20px;
  padding: 2rem;
  transition: all 0.3s ease;
}
.seu-novo-card:hover {
  border-color: var(--color-border-hover);
  transform: translateY(-4px);
}
```

### 4.3 Botão Primário (Call to Action)
```css
.btn-novo-primario {
  background: var(--gradient-brand);
  color: #fff; /* Branco absoluto garantido */
  border-radius: 10px;
  padding: 0.85rem 1.6rem;
  font-weight: 600;
  text-decoration: none;
}
```

### 4.4 Acessibilidade
Assegure o foco visível para elementos interativos gerados:
```css
.seu-elemento:focus-visible { 
  outline: 2px solid var(--color-accent-orange); 
  outline-offset: 4px; 
}
```
