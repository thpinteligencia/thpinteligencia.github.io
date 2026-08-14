// JavaScript logic for ArcoNorte Nexus Landing Page

document.addEventListener('DOMContentLoaded', () => {
    // ----------------------------------------------------
    // 1. Dynamic Theme Toggling (Light / Dark Mode)
    // ----------------------------------------------------
    const themeToggleBtn = document.getElementById('theme-toggle');
    
    // Function to set the theme
    const setTheme = (theme) => {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('theme', theme);
    };

    // Initialize theme based on localStorage or system preferences
    const initTheme = () => {
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme) {
            setTheme(savedTheme);
        } else {
            // Check system preference
            const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            setTheme(systemPrefersDark ? 'dark' : 'light');
        }
    };

    // Toggle button event listener
    if (themeToggleBtn) {
        themeToggleBtn.addEventListener('click', () => {
            const currentTheme = document.documentElement.getAttribute('data-theme') || 'dark';
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            setTheme(newTheme);
        });
    }

    // Listen to changes in system color scheme
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
        if (!localStorage.getItem('theme')) {
            setTheme(e.matches ? 'dark' : 'light');
        }
    });

    initTheme();

    // ----------------------------------------------------
    // 2. Interactive IPE (Outflow Pressure Index) Simulator
    // ----------------------------------------------------
    const safraInput = document.getElementById('safra-input');
    const capacidadeInput = document.getElementById('capacidade-input');
    
    const safraValLabel = document.getElementById('safra-val');
    const capacidadeValLabel = document.getElementById('capacidade-val');
    
    const ipePercentageLabel = document.getElementById('ipe-percentage');
    const gaugeFillPath = document.getElementById('gauge-fill');
    const gaugeNeedle = document.getElementById('gauge-needle');
    
    const statusCard = document.getElementById('status-card');
    const statusBullet = document.getElementById('status-bullet');
    const statusTitle = document.getElementById('status-title');
    const statusDesc = document.getElementById('status-desc');

    // Setup gauge path dash properties dynamically for perfect circular fill calculation
    let pathLength = 0;
    if (gaugeFillPath) {
        pathLength = gaugeFillPath.getTotalLength();
        gaugeFillPath.style.strokeDasharray = pathLength;
        gaugeFillPath.style.strokeDashoffset = pathLength;
    }

    // Formatter utility
    const formatTons = (value) => {
        return new Intl.NumberFormat('pt-BR').format(value) + ' t';
    };

    const updateSimulator = () => {
        if (!safraInput || !capacidadeInput) return;

        const safra = parseInt(safraInput.value, 10);
        const capacidade = parseInt(capacidadeInput.value, 10);

        // Update textual readouts
        safraValLabel.textContent = formatTons(safra);
        capacidadeValLabel.textContent = formatTons(capacidade);

        // Calculate IPE (Índice de Pressão de Escoamento)
        const ipe = Math.round((safra / capacidade) * 100);
        ipePercentageLabel.textContent = `${ipe}%`;

        // Update Gauge needle angle (-90deg at 0% to +90deg at 100% and beyond)
        const clampedIpe = Math.min(Math.max(ipe, 0), 120); // Cap needle at 120% visual max
        const needleAngle = -90 + (clampedIpe / 100) * 180;
        if (gaugeNeedle) {
            gaugeNeedle.style.transform = `rotate(${needleAngle}deg)`;
        }

        // Update Gauge Arc color and length
        if (gaugeFillPath && pathLength > 0) {
            // Fill arc according to IPE percentage (clamped to 100% representation for gauge fullness)
            const fillPercent = Math.min(Math.max(ipe, 0), 100);
            const offset = pathLength - (fillPercent / 100) * pathLength;
            gaugeFillPath.style.strokeDashoffset = offset;

            // Change color scheme based on intensity thresholds
            if (ipe < 75) {
                gaugeFillPath.style.stroke = 'var(--accent-green)';
            } else if (ipe < 95) {
                gaugeFillPath.style.stroke = 'var(--accent-yellow)';
            } else {
                gaugeFillPath.style.stroke = 'var(--accent-red)';
            }
        }

        // Update Diagnosis Card Status & CSS Classes
        if (statusCard) {
            // Clean classes
            statusCard.className = 'status-card';
            
            if (ipe < 75) {
                statusTitle.textContent = 'Logística Estável';
                statusDesc.textContent = 'O volume projetado é perfeitamente absorvido pela capacidade estática atual do Porto Seco. Escoamento seguro e fluido.';
            } else if (ipe < 95) {
                statusCard.classList.add('warning');
                statusTitle.textContent = 'Alerta de Sobrecarga';
                statusDesc.textContent = 'Atenção: A safra projetada está próxima do limite físico do terminal. Possível formação de filas rodoviárias de curta duração.';
            } else {
                statusCard.classList.add('danger');
                statusTitle.textContent = 'Gargalo Logístico Crítico';
                statusDesc.textContent = 'Alerta Vermelho: Capacidade logística superada! Tempo de espera elevado para navios e caminhões. Recomendado reter frotas em terminais reguladores.';
            }
        }
    };

    // Attach listeners
    if (safraInput && capacidadeInput) {
        safraInput.addEventListener('input', updateSimulator);
        capacidadeInput.addEventListener('input', updateSimulator);
    }

    // Run initial calculation on load
    updateSimulator();
});
