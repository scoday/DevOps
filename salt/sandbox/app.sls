scoday/jamwiki:
  dockerng.image_present:
    - force: true
    - name: scoday/jamwiki:latest

jamwiki: 
  dockerng.running:
    - name: jamwiki
    - image: scoday/jamwiki:latest
    - port_bindings: 8080:8080
