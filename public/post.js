const COPY_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect width="14" height="14" x="8" y="8" rx="2" ry="2"/><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"/></svg>';
const CHECK_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>';

document.querySelectorAll('.prose pre').forEach(pre => {
  const wrapper = document.createElement('div');
  wrapper.style.position = 'relative';
  pre.parentNode.insertBefore(wrapper, pre);
  wrapper.appendChild(pre);

  const btn = document.createElement('button');
  btn.className = 'copy-button';
  btn.setAttribute('aria-label', 'Copy code');
  btn.innerHTML = COPY_ICON;
  btn.addEventListener('click', async () => {
    await navigator.clipboard.writeText(pre.textContent || '');
    btn.innerHTML = CHECK_ICON;
    setTimeout(() => { btn.innerHTML = COPY_ICON; }, 2000);
  });
  wrapper.appendChild(btn);
});

document.querySelectorAll('.prose a').forEach(link => {
  const href = link.getAttribute('href');
  if (href && !href.startsWith('#')) {
    link.setAttribute('target', '_blank');
    link.setAttribute('rel', 'noopener noreferrer');
  }
});

const updateToc = () => {
  document.querySelectorAll('.toc-link').forEach(l => l.classList.remove('toc-active'));
  const hash = window.location.hash;
  if (hash) {
    const active = document.querySelector(`.toc-link[href="${hash}"]`);
    if (active) active.classList.add('toc-active');
  }
};
updateToc();
window.addEventListener('hashchange', updateToc);
