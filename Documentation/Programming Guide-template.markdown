Programming Guide
-----------------

This programming guide serves as a reference on how to go about using the included api.

String From Decimal Number 11.25
--------------------------------
```
self.textLabel.text = [JOECurrencyUtil stringFromDecimalNumber:decimalNumber];
// Outputs $11.25
```

Decimal Number From String $11.25
---------------------------------
```
self.decimalNumber = [JOECurrencyUtil decimalNumberFromCurrencyString:self.textLabel.text];
// Outputs 11.25
```
