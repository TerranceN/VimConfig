XPTemplate priority=personal

XPT hg
#ifndef `HEADERNAME^_H
#define `HEADERNAME^_H

`cursor^

#endif

XPT fch
// Purpose: `/*Purpose*/^
`returnType^ `fcnName^(`/*variables*/^);

XPT var
`type^ `varName^` = `newValue^;

XPT fc
// Purpose: `/*Purpose*/^
`returnType^ `fcnName^(`/*variables*/^)
{
    `/*code*/^
}

XPT if
if (`/*condition*/^)
{
    `/*code*/^
}

XPT for
for (int `i^ = `startingValue^; `i^ < `count^; `i^`++^)
{
    `/*code*/^
}

XPT wh
while (`condition^)
{
    `/*code*/^
}

XPT mig
#ifdef `OTHER_CLASS^_H
class `OtherClass^
#else
#include "`OtherClass^.h"
#endif

XPT str
struct `Name^
{
    `^
};

XPT tstr
XSET ComeFirst=0 Name
typedef struct _`Name^
{
    `^
} `Name^;
