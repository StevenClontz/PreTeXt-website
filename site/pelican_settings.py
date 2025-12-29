# This is a temporary version of the settings that would normally go in "site.json"
# Since we are using pelican directly instead of through the CLI, it is easier to have these here.

THEME = "./theme"
SITENAME = "PreTeXt"
SITESUBTITLE = "Write Once, Read Anywhere"
STATIC_PATHS = ["examples", "doc"]

RELATIVE_URLS = True
TIMEZONE = "America/Los_Angeles"
PAGE_PATHS = ["pages"]
ARTICLE_PATHS = ["updates"]
ARTICLE_URL = "updates/{date:%Y%m%d}-{slug}.html"
ARTICLE_SAVE_AS = "updates/{date:%Y%m%d}-{slug}.html"
PAGE_URL = "{slug}.html"
PAGE_SAVE_AS = "{slug}.html"
FEED_ALL_ATOM = None
FEED_ALL_RSS = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None
ARCHIVES_SAVE_AS = None
CATEGORIES_SAVE_AS = None
TAGS_SAVE_AS = None

