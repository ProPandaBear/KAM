#include "..\script_component.hpp"
#include "..\InteractionTable.hpp"
/*
 * Author: ProPandaBear
 * Computes drug interaction effects for a unit and writes results to
 * interaction channel variables consumed by fnc_handleUnitVitals.
 *
 * Called once per vitals cycle. To add new interactions, edit InteractionTable.hpp only.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Delta time <NUMBER>
 * 2: Sync values <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 1, false] call kat_pharma_fnc_updateInteractions;
 *
 * Public: No
 */

params ["_unit", "_deltaT", "_syncValues"];

private _intHR     = 0;
private _intOpioid = 0;
private _intPain   = 0;
private _intFlow   = 0;
private _intAlpha  = 0;
private _intPP     = 0;

{
    _x params ["_drugA", "_drugB", "_effects"];

    private _dosesA = ([_unit, _drugA] call ACEFUNC(medical_status,getMedicationCount)) select 0;
    if (_dosesA == 0) then { continue };

    private _dosesB = ([_unit, _drugB] call ACEFUNC(medical_status,getMedicationCount)) select 0;
    if (_dosesB == 0) then { continue };

    private _synergy = _dosesA * _dosesB;

    {
        _x params ["_channel", "_scale"];
        private _effect = _synergy * _scale;

        switch (_channel) do {
            case KAT_INT_HR:     { _intHR     = _intHR     + _effect };
            case KAT_INT_OPIOID: { _intOpioid = _intOpioid + _effect };
            case KAT_INT_PAIN:   { _intPain   = _intPain   + _effect };
            case KAT_INT_FLOW:   { _intFlow   = _intFlow   + _effect };
            case KAT_INT_ALPHA:  { _intAlpha  = _intAlpha  + _effect };
            case KAT_INT_PP:     { _intPP     = _intPP     + _effect };
        };
    } forEach _effects;
} forEach KAT_DRUG_INTERACTIONS;

_unit setVariable [QEGVAR(pharma,intHRAdj),        _intHR,     false];
_unit setVariable [QEGVAR(pharma,intOpioidAdj),    _intOpioid, false];
_unit setVariable [QEGVAR(pharma,intPainAdj),      _intPain,   false];
_unit setVariable [QEGVAR(pharma,intFlowAdj),      _intFlow,   false];
_unit setVariable [QEGVAR(pharma,intAlphaAdj),     _intAlpha,  false];
_unit setVariable [QEGVAR(pharma,intOpioidEffect), _intPP,     false];
