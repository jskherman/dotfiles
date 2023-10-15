const defaultConfig = {
	username: "jskherman",
	theme: {
		backgroundColor: "#121317",
		windowColor: "#1e212b",
		glowColor: "#6b5cb157",
		white: "#e2e2e2",
		gray: "#97989d",
		black: "#16161e",
		red: "#ec6183",
		green: "#2ed8a2",
		yellow: "#e8b195",
		blue: "#2bc3de",
		cyan: "#62e0e2",
		magenta: "#e069aa",
		violet: "#d1aff8",
		orange: "#ff8800"
	},
	wallpaper: {
		url: "",
		easing: "ease-in-out",
		fadeIn: true,
		blur: true
	},
	terminal: {
		fixedHeight: true,
		windowGlow: true,
		textGlow: false
	},
	prompt: {
		ctrlC: true,
		placeholder: "command...",
		placeholderColor: "gray",
		userColor: "green",
		atColor: "gray",
		hostColor: "magenta",
		promptColor: "magenta",
		promptSymbol: "❯",
		caretColor: "green",
		selectionBg: "yellow",
		selectionFg: "black"
	},
	fetch: {
		timeFormat: "HH:mm",
		dateFormat: "YYYY-MM-DD",
		titleColor: "yellow",
		image: "icon.svg",
		data: [
			"Time: {time}",
			"Date: {date}",
			"{seperator}",
			"OS: {osName} {osVersion}",
			"Browser: {browser} {browserVersion}",
			"Engine: {engineName}",
			"{seperator}",
			"{colors}"
		]
	},
	urlLaunch: {
		target: "_self",
		defaultColor: "white",
		hoverColor: "violet"
	},
	search: {
		default: "https://google.com/search?q=",
		target: "_self",
		shortcutRegex: "([A-Za-z0-9]+) (.*)",
		shortcuts: [
			{
				alias: "g",
				name: "Google Search",
				url: "https://google.com/search?q={}"
			},
			{
				alias: "b",
				name: "Bing Search",
				url: "https://www.bing.com/search?q={}"
			},
			{
				alias: "d",
				name: "DuckDuckGo Search",
				url: "https://duckduckgo.com/?q={}"
			},
			{
				alias: "sp",
				name: "Startpage Search",
				url: "https://www.startpage.com/sp/search?query={}"
			},
			{
				alias: "gh",
				name: "Github Search",
				url: "https://github.com/search?q={}"
			},
			{
				alias: "so",
				name: "Stack Overflow Search",
				url: "https://stackoverflow.com/search?q={}"
			},
			{
				alias: "r",
				name: "Reddit Search",
				url: "https://www.google.com/search?q=site%3Areddit.com+{}"
			},
			{
				alias: "rr",
				name: "Subreddit Search",
				url: "https://reddit.com/r/{}"
			},
			{
				alias: "w",
				name: "Wikipedia Search",
				url: "https://en.wikipedia.org/wiki/{}"
			},
			{
				alias: "ss",
				name: "Semantic Scholar Search",
				url: "https://www.semanticscholar.org/search?q={}&sort=relevance"
			},
			{
				alias: "gs",
				name: "Google Scholar Search",
				url: "https://scholar.google.com/scholar?&q={}"
			},
			{
				alias: "yt",
				name: "Youtube Search",
				url: "https://www.youtube.com/results?search_query={}"
			},
			{
				alias: "lib",
				name: "Library Genesis Search",
				url: "http://libgen.rs/search.php?req={}"
			},
			{
				alias: "@f",
				name: "Edge Favorites Search",
				url: "edge://favorites/?q={}"
			},
			{
				alias: "@h",
				name: "Edge History Search",
				url: "edge://history/all?q={}"
			}
		]
	},
	sections: {
		list: [
			{
				title: "General",
				color: "red",
				align: "left",
				links: [
					{
						name: "Website",
						url: "https://jskherman.com",
						icon: "mdi:web"
					},
					{
						name: "ChatGPT",
						url: "https://chat.openai.com/",
						icon: "simple-icons:openai"
					},
					{
						name: "BetterGPT",
						url: "https://bettergpt.chat/",
						icon: "simple-icons:openai"
					},
					{
						name: "TinyWow",
						url: "https://tinywow.com/",
						icon: "tabler:tool",
					},
					{
						name: "Paisa",
						url: "https://localhost:7500",
						icon: "simple-icons:cashapp"
					}
				]
			},
			{
				title: "Comms",
				color: "violet",
				align: "left",
				links: [
					{
						name: "GMail",
						url: "https://mail.google.com/",
						icon: "mdi:gmail"
					},
					{
						name: "Messenger",
						url: "https://messenger.com",
						icon: "simple-icons:messenger"
					},
					{
						name: "Telegram",
						url: "https://web.telegram.org/k/",
						icon: "simple-icons:telegram"
					},
					{
						name: "Discord",
						url: "https://discord.com",
						icon: "mdi:discord"
					}
				]
			},
			{
				title: "Social",
				color: "yellow",
				align: "left",
				links: [
					{
						name: "Firefish",
						url: "https://firefish.social/",
						icon: "simple-icons:firefish"
					},
					{
						name: "Twitter",
						url: "https://twitter.com",
						icon: "mdi:twitter"
					},
					{
						name: "Reddit",
						url: "https://reddit.com",
						icon: "mdi:reddit"
					},
					{
						name: "Facebook",
						url: "https://facebook.com",
						icon: "simple-icons:facebook"
					}
				]
			},
			{
				title: "Dev",
				color: "magenta",
				align: "left",
				links: [
					{
						name: "GitHub",
						url: "https://github.com",
						icon: "mdi:github"
					},
					{
						name: "Cloudflare",
						url: "https://dash.cloudflare.com/",
						icon: "simple-icons:cloudflare"
					},
					{
						name: "Fly.io",
						url: "https://fly.io/dashboard",
						icon: "fa6-brands:fly"
					},
					{
						name: "Stack Overflow",
						url: "https://stackoverflow.com/",
						icon: "mdi:stack-overflow"
					}
				]
			},
			{
				title: "Utils",
				color: "green",
				align: "left",
				links: [
					{
						name: "Calendar",
						url: "https://calendar.cron.com/",
						icon: "simple-icons:googlecalendar"
					},
					{
						name: "Todoist",
						url: "https://todoist.com/app/",
						icon: "simple-icons:todoist"
					},
					{
						name: "GoblinTools",
						url: "https://goblin.tools/",
						icon: "mdi:sword"
					},
					{
						name: "Tracker",
						url: "https://docs.google.com/spreadsheets/d/1g_tdpx8HMnyQvazqzlpqYjWog24osJ-B72z-92iKL_w/edit",
						icon: "mdi:google-spreadsheet"
					}
				]
			},
			{
				title: "Interesting",
				color: "cyan",
				align: "left",
				links: [
					{
						name: "Hacker News",
						url: "https://news.ycombinator.com/",
						icon: "fa:hacker-news"
					},
					{
						name: "Raindrop",
						url: "https://app.raindrop.io/",
						icon: "mdi:bookmark"
					},
					{
						name: "ADHD Wiki",
						url: "https://romankogan.net/adhd/",
						icon: "mdi:brain"
					},
					{
						name: "It's Foss",
						url: "https://itsfoss.com/",
						icon: "ri:mastodon-fill"
					},
				]
			}
		]
	}
}

export default defaultConfig
