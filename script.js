// Configuration
const BASE_PATH = 'C:/Users/matt/Documents/Uno/AI Generation/Prompt Comparison/';

// State management
let projects = [];
let currentProject = null;
let currentView = 'all';

// Initialize the application
async function init() {
    await loadProjects();
    renderProjectList();
    setupEventListeners();
    updateStats();
    // Auto-load first project
    if (projects.length > 0) {
        await selectProject(projects[0]);
    }
}

// Load all projects from the directory structure
async function loadProjects() {
    // Define all project folders
    const projectFolders = [
        '1. Flight Details',
        '2. Football Fantasy',
        '3. Travel Guide',
        '4. Electric Utility Dashboard',
        '5. Video Streaming',
        '6. Notes',
        '7. Calendar',
        '8. Hopital Dashboard',
        '9. Budgeting Dashboard',
        '10. Recipe Home Screen',
        '11. Fitness Tracking',
        '12. Login Register',
        '12. Sign In',
        '13. Travel Home Screen'
    ];

    projects = projectFolders.map(folder => ({
        name: folder,
        path: BASE_PATH + folder
    }));
}

// Render the project list in the sidebar
function renderProjectList() {
    const projectList = document.getElementById('project-list');
    projectList.innerHTML = '';

    projects.forEach(project => {
        const li = document.createElement('li');
        li.textContent = project.name;
        li.dataset.projectName = project.name;
        li.addEventListener('click', () => selectProject(project));
        projectList.appendChild(li);
    });
}

// Update statistics
function updateStats() {
    document.getElementById('total-projects').textContent = projects.length;
}

// Select and display a project
async function selectProject(project) {
    currentProject = project;
    currentView = 'all';

    // Update active state in sidebar
    document.querySelectorAll('.project-list li').forEach(li => {
        li.classList.remove('active');
        if (li.dataset.projectName === project.name) {
            li.classList.add('active');
        }
    });

    // Update project title
    document.getElementById('project-title').textContent = project.name;

    // Load and display prompts
    await loadPrompts(project);

    // Load and display images
    await loadImages(project);

    // Reset tab selection
    document.querySelectorAll('.tab-button').forEach(btn => {
        btn.classList.remove('active');
        if (btn.dataset.view === 'all') {
            btn.classList.add('active');
        }
    });
}

// Load prompts from Prompts.txt file
async function loadPrompts(project) {
    const promptsContent = document.getElementById('prompts-content');
    
    try {
        const response = await fetch(`${project.path}/Prompts.txt`);
        if (response.ok) {
            const text = await response.text();
            
            // Parse the prompts by tool
            const sections = parsePrompts(text);
            promptsContent.innerHTML = sections;
        } else {
            promptsContent.innerHTML = '<p style="color: #999;">No prompts file found for this project.</p>';
        }
    } catch (error) {
        promptsContent.innerHTML = '<p style="color: #999;">Unable to load prompts.</p>';
    }
}

// Parse prompts text into sections by tool
function parsePrompts(text) {
    const lines = text.split('\n');
    let currentTool = '';
    let sections = { UNO: [], LOVABLE: [], DREAMFLOW: [] };
    
    lines.forEach(line => {
        const trimmed = line.trim();
        if (trimmed === 'UNO' || trimmed === 'LOVABLE' || trimmed === 'DREAMFLOW') {
            currentTool = trimmed;
        } else if (trimmed && currentTool) {
            sections[currentTool].push(trimmed);
        }
    });

    let html = '';
    
    if (sections.UNO.length > 0) {
        html += `<div class="tool-section uno">
            <h4>🔷 UNO</h4>
            <div>${sections.UNO.join('<br>')}</div>
        </div>`;
    }
    
    if (sections.LOVABLE.length > 0) {
        html += `<div class="tool-section lovable">
            <h4>💖 LOVABLE</h4>
            <div>${sections.LOVABLE.join('<br>')}</div>
        </div>`;
    }
    
    if (sections.DREAMFLOW.length > 0) {
        html += `<div class="tool-section dreamflow">
            <h4>🌊 DREAMFLOW</h4>
            <div>${sections.DREAMFLOW.join('<br>')}</div>
        </div>`;
    }

    return html || '<p style="color: #999;">No structured prompts found.</p>';
}

// Load and display images for a project
async function loadImages(project) {
    const imagesGrid = document.getElementById('images-grid');
    imagesGrid.innerHTML = '<p>Loading images...</p>';

    // Fetch directory listing (simulate by trying common image names)
    const images = await discoverImages(project);
    
    if (images.length === 0) {
        imagesGrid.innerHTML = '<p style="color: #999;">No images found for this project.</p>';
        return;
    }

    renderImages(images);
}

// Discover images by attempting to load common patterns
async function discoverImages(project) {
    const images = [];
    const patterns = [
        // Uno patterns
        { name: 'Uno1.png', tool: 'uno', label: 'Uno - Version 1' },
        { name: 'Uno2.png', tool: 'uno', label: 'Uno - Version 2' },
        { name: 'Uno3.png', tool: 'uno', label: 'Uno - Version 3' },
        { name: 'Uno4.png', tool: 'uno', label: 'Uno - Version 4' },
        
        // Lovable patterns
        { name: 'Lovable1.png', tool: 'lovable', label: 'Lovable - Version 1' },
        { name: 'Lovable1-1.png', tool: 'lovable', label: 'Lovable - Prompt 1.1' },
        { name: 'Lovable1-2.png', tool: 'lovable', label: 'Lovable - Prompt 1.2' },
        { name: 'Lovable1-3.png', tool: 'lovable', label: 'Lovable - Prompt 1.3' },
        { name: 'Lovable1-4.png', tool: 'lovable', label: 'Lovable - Prompt 1.4' },
        { name: 'Lovable2-1.png', tool: 'lovable', label: 'Lovable - Prompt 2.1' },
        
        // Dreamflow patterns
        { name: 'Dreamflow1-Desktop.png', tool: 'dreamflow', label: 'Dreamflow - Desktop' },
        { name: 'Dreamflow1-Mobile.png', tool: 'dreamflow', label: 'Dreamflow - Mobile' },
        { name: 'Dreamflow2.png', tool: 'dreamflow', label: 'Dreamflow - Version 2' },
        { name: 'Dreamflow3.png', tool: 'dreamflow', label: 'Dreamflow - Version 3' },
        { name: 'Dreamflow4.png', tool: 'dreamflow', label: 'Dreamflow - Version 4' }
    ];

    // Check each pattern
    for (const pattern of patterns) {
        const path = `${project.path}/${pattern.name}`;
        if (await imageExists(path)) {
            images.push({
                path: path,
                tool: pattern.tool,
                label: pattern.label,
                name: pattern.name
            });
        }
    }

    // Sort images by tool and name
    images.sort((a, b) => {
        if (a.tool !== b.tool) {
            const toolOrder = { uno: 0, lovable: 1, dreamflow: 2 };
            return toolOrder[a.tool] - toolOrder[b.tool];
        }
        return a.name.localeCompare(b.name);
    });

    return images;
}

// Check if an image exists
async function imageExists(url) {
    try {
        const response = await fetch(url, { method: 'HEAD' });
        return response.ok;
    } catch {
        return false;
    }
}

// Render images in the grid
function renderImages(images) {
    const imagesGrid = document.getElementById('images-grid');
    
    // Filter images based on current view
    const filteredImages = currentView === 'all' 
        ? images 
        : images.filter(img => img.tool === currentView);

    if (filteredImages.length === 0) {
        imagesGrid.innerHTML = '<p style="color: #999;">No images for this filter.</p>';
        return;
    }

    imagesGrid.innerHTML = '';
    
    filteredImages.forEach(image => {
        const card = document.createElement('div');
        card.className = 'image-card';
        
        const img = document.createElement('img');
        img.src = image.path;
        img.alt = image.label;
        img.loading = 'lazy';
        img.addEventListener('click', () => openLightbox(image.path, image.label));
        
        const label = document.createElement('div');
        label.className = `image-label ${image.tool}`;
        label.textContent = image.label;
        
        card.appendChild(img);
        card.appendChild(label);
        imagesGrid.appendChild(card);
    });
}

// Setup event listeners
function setupEventListeners() {
    // Tab buttons
    document.querySelectorAll('.tab-button').forEach(button => {
        button.addEventListener('click', () => {
            currentView = button.dataset.view;
            
            // Update active state
            document.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('active');
            });
            button.classList.add('active');
            
            // Re-render images with filter
            if (currentProject) {
                loadImages(currentProject);
            }
        });
    });

    // Lightbox close
    document.querySelector('.lightbox-close').addEventListener('click', closeLightbox);
    document.getElementById('lightbox').addEventListener('click', (e) => {
        if (e.target.id === 'lightbox') {
            closeLightbox();
        }
    });

    // ESC key to close lightbox
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            closeLightbox();
        }
    });
}

// Open lightbox with image
function openLightbox(imagePath, caption) {
    const lightbox = document.getElementById('lightbox');
    const lightboxImg = document.getElementById('lightbox-img');
    const lightboxCaption = document.getElementById('lightbox-caption');
    
    lightbox.style.display = 'block';
    lightboxImg.src = imagePath;
    lightboxCaption.textContent = caption;
}

// Close lightbox
function closeLightbox() {
    document.getElementById('lightbox').style.display = 'none';
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
} else {
    init();
}
