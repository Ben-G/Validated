#2.0.1
*Released: 05/05/2016*

- Lowered iOS Deployment Target to 8.0 - @loganmoseley
- Update usage of `typealias` to `associatedtype` - @AndrewSB

#2.0
*Released: 03/02/2016*

**Breaking API Changes:**

- Removed `Validated2` and `Validated3` in favor of introduced logical wrapper validators - @Ben-G on suggestion of @tomquist
- Failable initializer of `Validated` now requires explicit `value` argument due to introduction of throwing initializer - @Ben-G
  
**API Additions:**

- Added wrapper validators for logical operators - @tomquist
- Added throwing initializer for `Validated` - @Ben-G upon suggestion of @radex

**Other Changes:**

- Major Refactoring of `Validated` Type - @dehesa
- Addition of OSX, tvOS and watchOS targets - @dehesae

#1.0
*Released: 02/24/2016*

 - Initial Release - @Ben-G