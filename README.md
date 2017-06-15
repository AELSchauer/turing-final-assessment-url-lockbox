# Production

[View Production Here](https://arcane-fortress-91308.herokuapp.com/)

# How to Use

## Signup & Login

You can sign up for an account with an email and password. You must login with the same email and password. There is no current functionality to change your email or password.

## Links

On the main page, you will the form to create a new link, the options to filter your existing links, and a list of all the links.

### Link Data

All links include a title, URL, and 'Read?' status.

### HotReads

URL Lockbox pairs with a service called 'HotReads', which aggregates all the links read by all lockbox users.

If a link is one of the top ten links in the last 24 hours, it will have the "HOT LINK" tag at the top. If it's the top link in the last 24 hours, it will have the "TOP LINK" tag at the top.

You can view the top HotRead links by going [here](https://fierce-beach-38151.herokuapp.com).


### Adding Links

On the main page, you can add a new link to your lockbox by entering the title and URL into the form. There are no restrictions on the title, but the URL must be the full and complete valid URL (i.e. includes 'http://' or 'https://' at the beginning).

When a link is added to your lockbox it is automatically marked as not read.

Adding a link does not automatically send the link to HotReads

### Reading or Unreading a Link

You may change the read status of the link by selecting the 'Mark As Read' or 'Mark As Unread' button below a link's data.

Once the link is marked as 'Read', the info will be sent to HotReads

Selecting 'Mark as Unread' or changing the status to "Read" multiple times will not change the standing of the link in HotReads.

#### Editing a Link

You may also edit either the title or URL of a link by selecting the 'Edit' button.

Editing the URL will not affect the old URL's standing on HotReads, but it may effect the standing of the new URL.


### Filtering Links

Once you have more than a few links, searching through all of them can become a challenge. There are two options to do this.


#### Filter by Text

In the textbox next to 'Filter By Text', the app will will perform a case insensitive search on both the title and URL of all the links as you type.

This is particularly helpful if you're looking for all the links from a single website. For example:

`wikipedia.org'

This is also useful if you're searching for all links that have a particular subject. For example:

`robot`


#### Filter by Status

Using the two buttons to the right of the search box, you can show only links that match the corresponding status.


#### Compound Filters

You can use a combination of the text filtering and status filtering.

So, for example, if you have a lot of links from a site, you can filter it down even more to find only the ones that are find only the ones that are unread.

#### Clearing the Filters

To clear out any filters, backspace in the filter textbox until it is empty. If it's already empty, backspace will clear any filters on the read status.


# How to Contribute

To contribute to this application, follow these steps:

1) Fork the repo and clone it onto your local computer.

2) Fork the [HotReads repo](https://github.com/AELSchauer/turing-final-assessment-hot-reads) and clone it onto your local computer.

3) Install the gems for each repo with `bundle install`

4) Startup the HotReads app with `rails server`. It runs on localhost:3001.

5) In a separate terminal window, startup the URL Lockbox app with `rails server`. It runs on localhost:3000.

*If you do not have both applications running simultaneously, URL Lockbox will NOT work!*

6) Start coding!

7) Add new or update any necessary model and feature tests for your changes. Test coverage must be above 90%.

8) Once you're ready to make a PR, run `rubocop` in your terminal and correct any style offenses.

9) In your PR, include a high level summary of what changes you made and why. *If your PR requires any changes to the HotReads repo, please include a link to the HotReads PR in your URL Lockbox PR description and add the tag [HotReads Update Required] to the title.*

Thank you!
