<?php
/**
 * Piwik - free/libre analytics platform
 *
 * @link http://piwik.org
 * @license http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 *
 */

namespace Piwik\Plugins\GCToolsTheme;

use Piwik\Plugin;

class GCToolsTheme extends Plugin
{
    public function getListHooksRegistered()
    {
        return [
            'Theme.configureThemeVariables' => 'configureThemeVariables',
        ];
    }

    public function configureThemeVariables(Plugin\ThemeStyles $vars)
    {
        $vars->fontFamilyBase = 'Arial, Verdana, sans-serif';
        $vars->colorBrand = '#5793d4';
        $vars->colorHeaderBackground = '#0091ea';
        $vars->colorHeaderText = '#0d0d0d';
    }
}
