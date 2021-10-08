let iconsLoopIndex = 0;
  let icons = [
    '📚',
    '👖',
    '🎬️',
    '💻',
    '👾',
    '💄',
    '🍔',
    '🎧',
    '🎓'
  ]
  var loop = setInterval(function () {
    let text = document.getElementById('highlighted-text-icon')
    if(text){
      text.innerText = icons[iconsLoopIndex]
      iconsLoopIndex++;
      if (iconsLoopIndex === 8) {
        iconsLoopIndex = 0;
      }
    }
   
  }, 1000)