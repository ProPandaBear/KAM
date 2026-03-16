// Drug Interaction Channel Constants
// Used as the channel identifier in each effect entry
#define KAT_INT_HR      "hr"       // Heart rate target adjustment (negative = bradycardia)
#define KAT_INT_OPIOID  "opioid"   // Opioid/respiratory depression (positive = more depression)
#define KAT_INT_PAIN    "pain"     // Pain suppression (positive = more relief)
#define KAT_INT_FLOW    "flow"     // Peripheral resistance / viscosity
#define KAT_INT_ALPHA   "alpha"    // Alpha factor / vasoconstriction
#define KAT_INT_PP      "pp"       // Post-processing visual effect

/*
 * KAT Drug Interaction Table
 *
 * Format: [drugA, drugB, [[channel, scalingFactor], ...]]
 *
 * Effect magnitude = dosesA * dosesB * scalingFactor
 * Both drugs must be present in the patient's system for the interaction to apply.
 * Multiple effects per interaction are supported.
 *
 * To add a new interaction, append an entry to this array following the format above.
 * No other files need to be modified for interactions using existing channels.
 */
#define KAT_DRUG_INTERACTIONS [\
    ["Morphine",   "Lorazepam",  [[KAT_INT_OPIOID, 0.15]]],\
    ["Fentanyl",   "Lorazepam",  [[KAT_INT_OPIOID, 0.20]]],\
    ["Nalbuphine", "Lorazepam",  [[KAT_INT_OPIOID, 0.10]]],\
    ["Morphine",   "Fentanyl",   [[KAT_INT_OPIOID, 0.10]]],\
    ["Morphine",   "Ketamine",   [[KAT_INT_PAIN,   0.10]]],\
    ["Fentanyl",   "Ketamine",   [[KAT_INT_PAIN,   0.10]]]\
]
