<?php

namespace frontend\modules\report\model;

use Yii;
use yii\report\Model;
use yii\data\ActiveDataProvider;
use frontend\modules\report\models\Cchangwat;

/**
 * CchangwatSearch represents the model behind the search form about `frontend\modules\base\models\Cchangwat`.
 */
class CchangwatSearch extends Cchangwat
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['changwatcode', 'changwatname', 'zonecode'], 'safe'],
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
        $query = Cchangwat::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        $query->andFilterWhere(['like', 'changwatcode', $this->changwatcode])
            ->andFilterWhere(['like', 'changwatname', $this->changwatname])
            ->andFilterWhere(['like', 'zonecode', $this->zonecode]);

        return $dataProvider;
    }
}
