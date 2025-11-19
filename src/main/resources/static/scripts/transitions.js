// Lightweight helper so pages can opt into the View Transitions API if supported.
// We avoid intercepting navigation because that was preventing pages from updating.
(function () {
  const supportsViewTransitions =
    typeof document !== 'undefined' &&
    typeof document.startViewTransition === 'function';

  window.triggerCardTransition = function (selector = '.card') {
    if (!supportsViewTransitions) {
      return;
    }
    const card = document.querySelector(selector);
    if (card) {
      card.style.viewTransitionName = 'card';
      document.startViewTransition(() => {
        // Intentionally empty; the API handles the animation.
      });
    }
  };
})();
