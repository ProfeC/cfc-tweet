Since I didn't see a decent Coldfusion implementation of Twitter that I needed for work, I decided to create my own...

# Implementation #
  1. update **accounts.cfc** with user names and passwords you want to use.
  1. load up index.cfm in your favorite browser and tweet away to multiple accounts at once.

### From a CommonSpot Datasheet ###
After you create your ds render module, this should be the text that is displayed for the column: (don't forget to remove the line breaks!)

```
<cfoutput><a href="##" 
 onclick="window.open('*{your relative address}*/twitter/index.cfm
 ?status=#urlEncodedFormat(*{the message you want to tweet}*)#
 &link=#urlEncodedFormat(*{the link you want added to the tweet}*)#
 &rlink=#urlEncodedFormat(*{a readable link for the url field at the bottom of the verification form}*)#
 &title=#urlEncodedFormat(*{a title for the labe}*)#',
 'tweetMe',
 'width=750,height=450,scrollbars=1')">
 Tweet&nbsp;This!</a>
</cfoutput>
```

There are a pair of link attributes being sent to the form because we use Coremetrics to track our marketing promotions. We didn't want an obcsure link that didn't mean anything showing on the verification form, so I send it two. One for Twitter and one for us to read.

## To Do's... at some point ##

  * here needs to be a better way to deal with clear passwords in a file. I don't really think it's an issue, but some might.
  * the confirmation page could be a little nicer, but since I'm using the form as a popup from a CommonSpot data sheet, I just needed it to confirm and close.
  * provide functions for all methods available from the Twitter API
  * figure out how to make this a custom application for Paper|Thin's CommonSpot

### Anyone who wants to help out with this, let me know and I will add you as a project member. ###