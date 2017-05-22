# URLockbox

URLockbox is a small application for tossing various forms of inspiration for later review.

-----

__Only what is up in production on heroku will be assessed__

-----

## Notes

- Manage yourself and your time. You have 16 hours split between two days to implement these features.

- You're welcome to use any library (e.g. lodash, Underscore, jQuery, React) you'd like as long as it does not replace the demonstrating proficiency in one of the skill areas addressed by the rubric below.

- For any given page, you can choose to render the initial content on the server _or_ you can provide an API and load it dynamically on the client. Unless otherwise specified, you have __full autonomy on technical implementation__. Just keep best practices and the rubric in mind (it's at the bottom of this file).

- Some of the features below are partially complete. The app you deliver should match the specs below, which means some of the existing features may need to be modified.

- These sections are ordered, but you wont be graded on the order in which they're completed.

- Don't over develop. If a feature isn't mentioned in the directions, it is not required. Overdeveloping can waste precious time.

---

## Section 1 - Sign Up, Sign In, and Sign Out

**Nota Bene**:

* You should aim to complete user auth in the simplest way possible. Using Rails' "built-in" gem Bcrypt is the most straightforward and recommended way to implement this functionality.
* Set goals and manage your work so that you keep in mind what you need to do and how long you have to do it.

As an _unauthenticated_ user, when I visit `/`, I should be _redirected_ to a page which prompts me to "Log In or Sign Up".

#### Sign Up

As an unauthenticated user, if I click "Sign Up", I should be taken to a form where I can
enter an **email address**, a **password**, and a **password confirmation**.

- I cannot sign up with an email address that has already been used.
- I cannot sign up without an email address and a password.
- Password and confirmation must match.
- If criteria is not met the user should be given a message to reflect the reason they could not sign up.

Upon submitting this information, I should be logged in and redirected to the "Links Index" page.

#### Sign In

As a registered user, when I attempt to sign in, I receive a flash message to reflect a successful or unsuccessful log in attempt.

#### Sign Out

As an authenticated user viewing the index page, I should see a link to "Sign Out" and not see a link to "Sign In". This "Sign Out" link should redirect me back to the page that prompts me to "Log In or Sign Up".

---

## Section 2 - Submitting and Viewing Links

As an _authenticated user_ viewing the main page (`links#index`),
I should see a simple form to submit a link.

A link includes:

1. A _valid_ URL for the link

1. A title for the link

1. A `read` status that is either true or false.

When editing, or creating a link:

1. Read status will default to `false`, and not be included in the create or edit form.

1. Submitting an invalid link should result in an error message being displayed that indicated why the user was not able to add the link.

**Hint:** You can use Ruby's built in `URI.parse` method to determine if a link is a valid or not. This [StackOverflow post][urip] has more information. Alternatively, you could use a gem like [this one][vurl].

[urip]: http://stackoverflow.com/questions/7167895/whats-a-good-way-to-validate-links-urls-in-rails
[vurl]: https://github.com/perfectline/validates_url

Once a link has been submitted, loading the index page should display all of _my_ links __only__.

---

### Section 3 - Editing Links

As an authenticated user who has added links to my URLockbox,
when I view the links index:

1.  Each link has an "Edit" button that either takes me to a page to edit the link or allows me to edit the link in place on the page.

1.  I can edit the title and/or the url of the link.

1.  I should see flash messages indicating a successful edit, or the reason why my edit was invalid.

---

### Section 4 - Client-Side

## **As an authenticated user, I can do the following in the Links index without reloading the page:**

### Creating links

- Create a new link, and see it in added to the top of the list.
- Ensure that flash messages continue to appear.

### Mark a link as "read" or "unread"

_There is some JS already written to help you mark a link as read._

1. Next to each **unread** link I should see an option to "Mark as Read".
  - Clicking this should visibly change the `read` status to true, and the change should persist.
2. Next to each **read** link I should see an option to "Mark as Unread".
  - Clicking this should change the `read` status to false, and the change should persist.
3. Read links should be stylistically differentiated from unread links. You could gray them out or use a strike through or __anything__ you think appropriately informs the user that their link is read or unread.

### Filtering

1. Filter the list of links by a search term as I type into a search box. Filter by both title and url with each key press. This filtering should not be case sensitive.
2. Click a "Show Read" button or link to show only links where the read status is true.
2. Click a "Show Unread" button or link to show only links where the read status is false.

Notes Bene:

* If you choose to use React __you will need to rewrite the functionality__ that was written in jQuery.

* Making AJAX requests between two different hosts/apps/domains will cause a CORS error. If you're unfamiliar with this, check out [this documentation](https://spring.io/understanding/CORS). How to implement this is up to you. You can find many rails resources to solve this error.

* Note: AJAX requests are not the **only** way to send data from one place to another (in the section below)

---

### Section 5 - Implementing a Service

Build a second application called "Hot Reads" that fulfills the following requirements.

- When a link is marked as read in the main application (URLLockBox), the link's url is sent to Hot Reads, which creates a record of the "read".

- As an unauthenticated user, I can visit the Hot Reads main index page and see a list of the top-10 most-read URLs (not titles or URL/title combos) across all users. Only reads from the last 24 hours should count towards the ranking. _Count URLs read by different users as the same URL_

Now that you have this second application, add the following functionality to your main application:

- When I load the links index:
  * If a link is in Hot Read's current top-10, mark it as "hot"
  * If a link is currently number one in the top-10, mark it as "top link"

---

## Additional Features (Bonus - Time Permitting)

Make sure that your project implementation is strong before considering any of the Supporting Features below.

### Forward Link to an Email Address

As an authenticated user if I add a tag to send that link to the email address `\cc: email@example.com`, URLockbox will send that link to the email address. The link will be saved as the link only without that line about ccing to the email address:

Example:

You will enter:
`www.turing.io/portfolios \cc: andrew@turing.io`

and URLockbox will save the link as:

- `www.turing.io/portfolios`

your program will not save or persist the email at all.

### Live Page Summary

It would be great to get a little information about our links, like a summary of what you'll find when you visit that link. Luckily this is the internet and we can do that!

Whenever a new link is submitted, use an HTTP client service, or scraper to pull the contents of the provided page.

From the page you're trying to link to, pull 2 pieces of information -- the page's `<title>` attribute and its `<h1>`.  Use these to construct a short "summary" for the linked page below the link on your Links Index page.

Mega bonus points if you use a background job processing library to perform this request asynchronously. If you do this, you can fill each link with an initial summary of "Summary Pending" and update the data in your background job.

Note: A proper HTML document will only have a single `<h1>` element on the page. However you may encounter documents that use more than one. In these cases just use the first `<h1>` you encounter.

_Note Bene:_

This feature is not considered done if you do not handle the edge cases. Ex: A page does not have an h1 or title. Or, a page redirects and fails. You are expected to handle these kinds of common edge cases.

### Organizing Links with Tags

Wow - we've saved a lot of links. Our URLockbox is filling up quick and we can't seem to find anything very easily. Let's solve our own problems. Fix this by adding the ability to tag or categorize our links. All of these can be implemented with or without JavaScript.  

You should be able to:

- Add one or multiple tags to a link. If you're entering more than one tag you should be able to separate them by a comma and they will all be added to that link.
- Remove a tag from a link
- Click on the tag from that link and see all the links associated with that tag

---


## Rubric

Subjective evaluation will be made on your work/process according to the following criteria:

### 1. Satisfactory Progress

* 4: Developer completes sections 1 through 5 with no bugs and has one or more supporting feature implemented.
* 3: Developer completes sections 1 through 5 minor bugs and no missing functionality.
* 2: Developer completes sections 1 through 5 with some _minor_ bugs or missing functionality.
* 1: Developer fails to complete sections 1 through 5 or there are significant issues with delivered functionality.

### 2. Ruby & Rails Style & API

* 4: Developer is able to craft Rails features that follow the principles of MVC, push business logic down the stack, and skillfully utilizes ActiveRecord to model application state. Developer can speak to choices made in the code and knows what every line of code is doing.
* 3: Developer generally writes clean Rails features that make smart use of Ruby, with some struggles in pushing logic down the stack. The application displays good judgement in modeling the problem as data. Developer can speak to choices made in the code and knows what every line of code is doing.
* 2: Developer struggles with some concepts of MVC.  Developer is not confident in what every line of the code is doing or cannot speak to the choices made.
* 1: Developer struggles with MVC and pushing logic down the stack
* 0: Developer shows little or no understanding of how to craft Rails applications

### 3. Javascript Syntax & Style

* 4: Developer uses elegant and idiomatic Javascript to accomplish common tasks. Demonstrates solid understanding of function passing and manipulation. Developer can speak to choices made in the code and knows what every line of code is doing.
* 3: Developer writes solid Javascript code using common patterns and idioms. Code is organized appropriately within objects and functions. Developer can speak to choices made in the code and knows what every line of code is doing.
* 2: Developer can accomplish basic tasks with Javascript but implementation is largely copy/pasted or non-idiomatic. Developer is not confident in what every line of the code is doing or cannot speak to the choices made.
* 1: Developer can manipulate Javascript syntax but implementation is buggy or inconsistent.
* 0: Developer shows little or no understanding of Javascript syntax and idioms

### 4. Testing

* 4: Developer excels at taking small steps and using the tests for *both* design and verification. Developer uses integration tests, controller tests, and model tests where appropriate.
* 3: Developer writes tests that are effective validation of functionality, but don't drive the design. Developer uses integration tests, controller tests, and model tests where appropriate.
* 2: Developer uses tests to guide development, but implements more functionality than the tests cover. Application is missing tests in a needed area such as model, integration, or controller tests.
* 1: Developer is able to write tests, but they're written after or in the middle of implementation.
* 0: Developer does not use tests to guide development.

### 5. User Interface

* 4: The application is pleasant, logical, and easy to use
* 3: The application has many strong pages/interactions, but a few holes in lesser-used functionality
* 2: The application shows effort in the interface, but the result is not effective
* 1: The application is confusing or difficult to use

### 6. Documentation

* 4: Project features excellent documentation showing how to develop the application including a screencast or tutorial
* 3: Project features excellent documentation showing how to develop the applications
* 2: Project features barebones documentation showing how to get the dev environment up and running
* 1: Project has insufficient documentation

### 7. Workflow

* 4: The developer effectively uses Git branches and many small, atomic commits that document the evolution of their application.
* 3: The developer makes a series of small, atomic commits that document the evolution of their application. There are no formatting issues in the code base.
* 2: The developer makes large commits covering multiple features that make it difficult for the evaluator to determine the evolution of the application.
* 1: The developer committed the code to version control in only a few commits. The evaluator cannot determine the evolution of the application.
* 0: The application was not checked into version control.
