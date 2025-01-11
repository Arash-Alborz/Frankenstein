// Declare variables for getting the xml file for the XSL transformation (folio_xml) and to load the image in IIIF on the page in question (number).
let tei = document.getElementById("folio");
let tei_xml = tei.innerHTML;
let extension = ".xml";
let folio_xml = tei_xml.concat(extension);
let page = document.getElementById("page");
let pageN = page.innerHTML;
let number = Number(pageN);

// Loading the IIIF manifest
var mirador = Mirador.viewer({
  "id": "my-mirador",
  "manifests": {
    "https://iiif.bodleian.ox.ac.uk/iiif/manifest/53fd0f29-d482-46e1-aa9d-37829b49987d.json": {
      provider: "Bodleian Library, University of Oxford"
    }
  },
  "window": {
    allowClose: false,
    allowWindowSideBar: true,
    allowTopMenuButton: false,
    allowMaximize: false,
    hideWindowTitle: true,
    panels: {
      info: false,
      attribution: false,
      canvas: true,
      annotations: false,
      search: false,
      layers: false,
    }
  },
  "workspaceControlPanel": {
    enabled: false,
  },
  "windows": [
    {
      loadedManifest: "https://iiif.bodleian.ox.ac.uk/iiif/manifest/53fd0f29-d482-46e1-aa9d-37829b49987d.json",
      canvasIndex: number,
      thumbnailNavigationPosition: 'off'
    }
  ]
});

// Function to transform the text encoded in TEI with the XSL stylesheet "Frankenstein_text.xsl"
function documentLoader() {
    Promise.all([
      fetch(folio_xml).then(response => response.text()),
      fetch("Frankenstein_text.xsl").then(response => response.text())
    ])
    .then(function ([xmlString, xslString]) {
      var parser = new DOMParser();
      var xml_doc = parser.parseFromString(xmlString, "text/xml");
      var xsl_doc = parser.parseFromString(xslString, "text/xml");

      var xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl_doc);
      var resultDocument = xsltProcessor.transformToFragment(xml_doc, document);

      var criticalElement = document.getElementById("text");
      criticalElement.innerHTML = ''; // Clear existing content
      criticalElement.appendChild(resultDocument);
    })
    .catch(function (error) {
      console.error("Error loading documents:", error);
    });
}

// Function to transform the metadata encoded in teiHeader with the XSL stylesheet "Frankenstein_meta.xsl"
function statsLoader() {
    Promise.all([
      fetch(folio_xml).then(response => response.text()),
      fetch("Frankenstein_meta.xsl").then(response => response.text())
    ])
    .then(function ([xmlString, xslString]) {
      var parser = new DOMParser();
      var xml_doc = parser.parseFromString(xmlString, "text/xml");
      var xsl_doc = parser.parseFromString(xslString, "text/xml");

      var xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl_doc);
      var resultDocument = xsltProcessor.transformToFragment(xml_doc, document);

      var criticalElement = document.getElementById("stats");
      criticalElement.innerHTML = ''; // Clear existing content
      criticalElement.appendChild(resultDocument);
    })
    .catch(function (error) {
      console.error("Error loading documents:", error);
    });
}

documentLoader();
statsLoader();

function selectHand(event) {
    const visible_mary = document.querySelectorAll('[hand="#MWS"]');
    const visible_percy = document.querySelectorAll('[hand="#PBS"]');

    var MaryArray = Array.from(visible_mary);
    var PercyArray = Array.from(visible_percy);

    if (event.target.value === 'both') {
        MaryArray.forEach(element => {
            element.style.color = 'black';
            element.style.backgroundColor = 'transparent';
        });
        PercyArray.forEach(element => {
            element.style.color = 'black';
            element.style.backgroundColor = 'transparent';
        });
    } else if (event.target.value === 'Mary') {
        MaryArray.forEach(element => {
            element.style.color = '#7d3120';
            element.style.backgroundColor = 'transparent'
        });
        PercyArray.forEach(element => {
            element.style.color = '#AAAAAA';
            element.style.backgroundColor = 'transparent';
        });
    } else if (event.target.value === 'Percy') {
        PercyArray.forEach(element => {
            element.style.color = '#7d3120';
            element.style.backgroundColor = 'transparent';
        });
        MaryArray.forEach(element => {
            element.style.color = '#AAAAAA';
            element.style.backgroundColor = 'transparent';
        });
    }
}

document.getElementById('sel-hand').addEventListener('change', selectHand);

function toggleDeletions() {
    const deletions = document.querySelectorAll('.del');
    deletions.forEach(deletion => {
        deletion.style.display = deletion.style.display === 'none' ? 'inline' : 'none';
    });
}

document.getElementById('toggle-deletions').addEventListener('click', toggleDeletions);
// Toggle reading version (hide deletions and show additions inline)
function toggleReadingVersion() {
  const deletions = document.querySelectorAll('.del');
  const additions = document.querySelectorAll('.supraAdd');
  
  // Hide all deletions
  deletions.forEach(deletion => deletion.style.display = 'none');
  
  // Set supralinear additions to inline (remove superscript style)
  additions.forEach(addition => {
      addition.style.fontStyle = 'normal';  // Remove italic style (if any)
      addition.style.verticalAlign = 'unset';  // Remove vertical alignment (superscript)
      addition.style.display = 'inline';  // Ensure it's inline like normal text
  });
}

document.getElementById('toggle-reading').addEventListener('click', toggleReadingVersion);


// write another function that will toggle the display of the deletions by clicking on a button
// EXTRA: write a function that will display the text as a reading text by clicking on a button or another dropdown list, meaning that all the deletions are removed and that the additions are shown inline (not in superscript)