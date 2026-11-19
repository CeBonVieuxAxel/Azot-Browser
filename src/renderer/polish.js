(() => {
  const reload = document.getElementById('reload');
  const reloadSymbol = document.getElementById('i-reload');
  if (!reload || !reloadSymbol) return;

  reloadSymbol.setAttribute('viewBox', '0 0 24 24');
  reloadSymbol.setAttribute('width', '18');
  reloadSymbol.setAttribute('height', '18');
  reloadSymbol.setAttribute('fill', 'none');
  reloadSymbol.setAttribute('stroke', 'currentColor');
  reloadSymbol.setAttribute('stroke-width', '1.8');
  reloadSymbol.setAttribute('stroke-linecap', 'round');
  reloadSymbol.setAttribute('stroke-linejoin', 'round');
  reloadSymbol.innerHTML = '<path d="M20 12a8 8 0 1 1-2.34-5.66"/><path d="M20 5v5h-5"/>';

  reload.addEventListener('click', () => {
    reload.classList.remove('is-spinning');
    void reload.offsetWidth;
    reload.classList.add('is-spinning');
  });

  const observeLoading = () => reload.classList.toggle('is-loading', document.getElementById('progress')?.classList.contains('loading'));
  new MutationObserver(observeLoading).observe(document.getElementById('progress'), { attributes: true, attributeFilter: ['class'] });
  observeLoading();
})();
