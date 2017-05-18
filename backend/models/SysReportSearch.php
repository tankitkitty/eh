<?php

namespace backend\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use backend\models\SysReport;

/**
 * SysReportSearch represents the model behind the search form about `backend\models\SysReport`.
 */
class SysReportSearch extends SysReport
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['report_id', 'active', 'pageview'], 'integer'],
            [['report_name', 'a_table', 's_table', 't_table', 't_sql', 's_sql', 'a_sql', 'aname', 'bname', 'notice', 'report_procedure', 'menu_group', 'defination', 'docs', 'ref'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = SysReport::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        $query->andFilterWhere([
            'report_id' => $this->report_id,
            'active' => $this->active,
            'pageview' => $this->pageview,
        ]);

        $query->andFilterWhere(['like', 'report_name', $this->report_name])
            ->andFilterWhere(['like', 'a_table', $this->a_table])
            ->andFilterWhere(['like', 's_table', $this->s_table])
            ->andFilterWhere(['like', 't_table', $this->t_table])
            ->andFilterWhere(['like', 't_sql', $this->t_sql])
            ->andFilterWhere(['like', 's_sql', $this->s_sql])
            ->andFilterWhere(['like', 'a_sql', $this->a_sql])
            ->andFilterWhere(['like', 'aname', $this->aname])
            ->andFilterWhere(['like', 'bname', $this->bname])
            ->andFilterWhere(['like', 'notice', $this->notice])
            ->andFilterWhere(['like', 'report_procedure', $this->report_procedure])
            ->andFilterWhere(['like', 'menu_group', $this->menu_group])
            ->andFilterWhere(['like', 'defination', $this->defination])
            ->andFilterWhere(['like', 'docs', $this->docs])
            ->andFilterWhere(['like', 'ref', $this->ref]);

        return $dataProvider;
    }
}
