let portFromCS;

let connected = (port) => {
  portFromCS = port;
  portFromCS.onMessage.addListener((message) => {
    window.fetch(`http://localhost:3000/${message.screen_name}`).
      then(response => response.json()).
      then((json) => {
        portFromCS.postMessage(json);
      }).
      catch(error => console.error(error))
  });
};

browser.runtime.onConnect.addListener(connected);
