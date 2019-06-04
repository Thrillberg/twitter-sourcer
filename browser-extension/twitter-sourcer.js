let port = browser.runtime.connect({name: "Twitter Sourcer"});
port.onMessage.addListener((message) => {
  let tweet = document.getElementById(`stream-item-tweet-${message.id}`);
  insertNodeAfter(tweet);
});

let stream = document.getElementById("stream-items-id");
let config = { attributes: true, childList: true, subtree: false };

let insertNodeAfter = (tweet) => {
  let node = document.createElement("span");
  node.classList.add("alert");
  node.textContent = "🇷🇺  This is an official Russian account.";
  stream.insertBefore(node, tweet.nextSibling);
}

let needsAlert = (child) => {
  if (child.classList && child.classList.contains("tweet")) {
    port.postMessage({
      screen_name: child.getAttribute("data-screen-name"),
      id: child.getAttribute("data-item-id")
    })
  };

  return false;
}

let insertAlerts = (tweet) => {
  tweet.childNodes.forEach((child) => {
    needsAlert(child)
  });
};

let handleOriginalTweets = () => {
  let tweets = stream.getElementsByClassName("stream-item");
  for (let tweet of tweets) {
    insertAlerts(tweet);
  };
};

let handleSubsequentTweets = (mutationsList, observer) => {
  for (let mutation of mutationsList) {
    if (mutation.addedNodes.length > 0) {
      mutation.addedNodes.forEach((tweet) => {
        insertAlerts(tweet);
      });

      observer.disconnect();
      new MutationObserver(handleSubsequentTweets).observe(stream, config);
    };
  };
};

handleOriginalTweets();
let observer = new MutationObserver(handleSubsequentTweets);
observer.observe(stream, config);
