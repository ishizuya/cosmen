if (document.URL.match(/new/),(/edit/)){
  document.addEventListener('DOMContentLoaded', () => {
      const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);
      blobImage.classList.add('preview-size');
      imageElement.appendChild(blobImage);
    };

    document.getElementById('item_image').addEventListener('change', (e) =>{
      const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}