const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.only-home');
  if (navbar) {
    window.addEventListener('scroll', () => {
      console.log(window.scrollY);
      console.log(window.innerHeight);
      if (window.scrollY >= 76 && window.scrollY <= 550) {
        navbar.classList.add('fixed-only-home');
      } else {
        navbar.classList.remove('fixed-only-home');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
