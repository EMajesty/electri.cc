let trailElements = [];
let lastScrollY = window.scrollY;
let ticking = false;

function createTrailElement(element) {
  const rect = element.getBoundingClientRect();
  const trailElement = element.cloneNode(true);
  trailElement.className = 'trail-text';
  trailElement.style.left = rect.left + 'px';
  trailElement.style.top = (rect.top + window.scrollY) + 'px';
  trailElement.style.width = rect.width + 'px';
  trailElement.style.height = rect.height + 'px';
  
  document.body.appendChild(trailElement);
  trailElements.push(trailElement);
  
  if (trailElements.length > 20) {
    const oldestElement = trailElements.shift();
    oldestElement.style.opacity = '0';
    setTimeout(() => {
      document.body.removeChild(oldestElement);
    }, 500);
  }
  
  setTimeout(() => {
    trailElement.style.opacity = '0';
  }, 100);
}

function handleScroll() {
  if (!ticking) {
    window.requestAnimationFrame(() => {
      const scrollDiff = window.scrollY - lastScrollY;
      if (Math.abs(scrollDiff) > 5) {  // Only create trail if scrolled more than 5 pixels
        const boldElements = document.querySelectorAll('strong, b');
        boldElements.forEach(element => {
          if (isElementInViewport(element)) {
            createTrailElement(element);
          }
        });
        lastScrollY = window.scrollY;
      }
      ticking = false;
    });
    ticking = true;
  }
}

function isElementInViewport(el) {
  const rect = el.getBoundingClientRect();
  return (
    rect.top >= 0 &&
    rect.left >= 0 &&
    rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
    rect.right <= (window.innerWidth || document.documentElement.clientWidth)
  );
}

window.addEventListener('scroll', handleScroll);

