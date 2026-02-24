# pretextbook.org

This is the repository for the home page for PreTeXt, to be hosted at [pretextbook.org](https://pretextbook.org).

## Structure

The landing pages for the website are stored in the `site` directory, as markdown files.  These are processed with Pelican to create the main pages.

However, most of the content in the site are builds of pretext documents.  All this is controlled by build script: `scripts/build.sh`.  

## Testing

To build the pelican generated pages, from the `site` directory, run

```bash
pelican . -o ../output -s pelican_settings.py
```

The easiest way to view the site is to spin up a python web server, using `python -m http.server -d ../output/` (assuming you are still in the `site` directory).
